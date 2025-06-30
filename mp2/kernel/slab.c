#include "types.h"
#include "param.h"
#include "memlayout.h"

#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"

#include "riscv.h"
#include "defs.h"
#include "slab.h"
#include "debug.h"

void print_kmem_cache(struct kmem_cache *cache, void (*slab_obj_printer)(void *))
{
	// TODO: Implement print_kmem_cache
	/*
	printf("[SLAB] TODO: print_kmem_cache is not yet implemented \n");
	*/
	acquire(&cache->lock);
	uint max_objs = (PGSIZE - sizeof(struct kmem_cache)) / cache->object_size;
	debug("[SLAB] kmem_cache { name: %s, object_size: %u, at: %p, in_cache_obj: %d }\n", 
	   cache->name, cache->object_size, cache, max_objs);
	//
    char *obj = (char *)cache + sizeof(struct kmem_cache);
    int idx = 0;
    debug("[SLAB]     [ cache slabs ]\n");
    debug("[SLAB]          [ slab %p ] { freelist: %p, nxt: %p }\n", cache, cache->freelist, (void *)0); 
    for (uint i = 0; i < max_objs; i++) {
        debug("[SLAB]          [ idx %u ] { addr: %p, as_ptr: %p,", i, obj, *(void **)obj);
        if (slab_obj_printer) {
            debug(" as_obj: { ");
            slab_obj_printer(obj);
            debug(" }");
        }
        debug(" }\n");
        obj += cache->object_size;
        idx++;
    }
	//
    
    // print partial
    struct slab *slab;
	struct list_head *next_list = (&cache->partial)->next;
    list_for_each_entry(slab, &cache->partial, list) {
    	char *obj = (char *)slab + sizeof(struct slab); // first object i.e. freelist base address
    	debug("[SLAB]     [ partial slabs ]\n");
    	debug("[SLAB]          [ slab %p ] { freelist: %p, nxt: %p }\n", slab, slab->freelist, next_list); 
		next_list = next_list->next;
        
        idx = 0;
		for (int i = 0; i < (PGSIZE - sizeof(struct slab)) / cache->object_size; i++){
			debug("[SLAB]                [ idx %d ] { addr: %p, as_ptr: %p,", idx, obj, *(void **)obj);
            if (slab_obj_printer) {
                debug(" as_obj: { ");
                slab_obj_printer(obj);
                debug("} }\n");
            }
            obj += cache->object_size; // Move to next object
            idx++;
		}
	}
    /*
    // print partial
	struct list_head *next_list = (&cache->partial)->next;
    list_for_each_entry(slab, &cache->partial, list) {
        debug("[SLAB]     [ partial slabs ]\n");
        debug("[SLAB]          [ slab %p ] { freelist: %p, nxt: %p }\n", slab, slab->freelist, next_list); 
        next_list = next_list->next;
        struct run *freelist = slab->freelist;
        int idx = 0;
        while (freelist) {
            debug("[SLAB]                [ idx %d ] { addr: %p }", idx, freelist);
            if (slab_obj_printer) {
                debug(" as_obj: { ");
                slab_obj_printer(freelist);
                debug(" }\n");
            }
            freelist = freelist->next;
            idx++;
        }
    }
    */
    debug("[SLAB] print_kmem_cache end\n");
    release(&cache->lock);
}

struct kmem_cache *kmem_cache_create(char *name, uint object_size)
{
  // TODO: Implement kmem_cache_create
  /*
  printf("[SLAB] TODO: kmem_cache_create is not yet implemented \n");
  
  struct kmem_cache *cache;
  cache = 0;
  return cache;
  */
  struct kmem_cache *cache = (struct kmem_cache *)kalloc();
  if (!cache) 
    return 0;

  strncpy(cache->name, name, sizeof(cache->name) - 1);
  cache->name[sizeof(cache->name) - 1] = '\0';
  cache->object_size = object_size;
  initlock(&cache->lock, "kmem_cache");
  
  INIT_LIST_HEAD(&cache->full);
  INIT_LIST_HEAD(&cache->partial);
  INIT_LIST_HEAD(&cache->free);

  uint max_objs = (PGSIZE - sizeof(struct slab)) / object_size;
  uint max_cache_objs = (PGSIZE - sizeof(struct kmem_cache)) / object_size;
  //
  // Initialize freelist inside kmem_cache
  cache->freelist = (struct run *)((char *)cache + sizeof(struct kmem_cache));
  struct run *run = cache->freelist;
 
  for (int i = 1; i < max_cache_objs; i++) {
    run->next = (struct run *)((char *)run + object_size);
    run = run->next;
  }
  run->next = NULL; // End of freelist
  //
  acquire(&cache->lock);

  debug("[SLAB] New kmem_cache (name: %s, object size: %d bytes, at: %p, max objects per slab: %d, support in cache obj: %d) is created\n", 
         cache->name, cache->object_size, cache, max_objs, max_cache_objs);
  release(&cache->lock);
  return cache;
}

void kmem_cache_destroy(struct kmem_cache *cache)
{
  // TODO: Implement kmem_cache_destroy (will not be tested)
  // acquire(&cache->lock);
  printf("[SLAB] TODO: kmem_cache_destroy is not yet implemented \n");
  // release(&cache->lock);
}

void *kmem_cache_alloc(struct kmem_cache *cache)
{
	// TODO: Implement kmem_cache_alloc
	/*
	printf("[SLAB] TODO: kmem_cache_alloc is not yet implemented \n");

	// acquire(&cache->lock); // acquire the lock before modification
	// ... (modify kmem_cache)
	// release(&cache->lock); // release the lock before return
	return 0;
	*/
	acquire(&cache->lock);
    debug("[SLAB] Alloc request on cache %s\n", cache->name);
    //
    // Try allocating from kmem_cache's freelist first
    if (cache->freelist) {
        void *obj = cache->freelist;
        cache->freelist = cache->freelist->next;
        debug("[SLAB] Object %p in slab %p (%s) is allocated and initialized\n", obj, cache, cache->name);
        release(&cache->lock);
        return obj;
    }
    //

    struct slab *s = NULL;

    // Try partial slabs first
    if (!list_empty(&cache->partial)) {
        s = list_first_entry(&cache->partial, struct slab, list);
    } 
    // Otherwise, use free slabs
    else if (!list_empty(&cache->free)) {
        s = list_first_entry(&cache->free, struct slab, list);
        list_del(&s->list);
        list_add_tail(&s->list, &cache->partial);
    } 
    // Otherwise, allocate a new slab
    else {
        s = (struct slab *)kalloc();
        if (!s) {
            release(&cache->lock);
            return 0;
        }

        s->freelist = (struct run *)((char *)s + sizeof(struct slab));
        struct run *run = s->freelist;

        // Initialize freelist in slab
        for (int i = 1; i < (PGSIZE - sizeof(struct slab)) / cache->object_size; i++) {
            run->next = (struct run *)((char *)run + cache->object_size);
            run = run->next;
        }
        run->next = NULL;
        s->in_use = 0;
        list_add_tail(&s->list, &cache->partial);

        debug("[SLAB] A new slab %p (%s) is allocated\n", s, cache->name);
    }

    // Allocate object
    void *obj = s->freelist;
    s->freelist = s->freelist->next;
    s->in_use++;

    debug("[SLAB] Object %p in slab %p (%s) is allocated and initialized\n", obj, s, cache->name);

    // Move to full if needed
    if (s->in_use == (PGSIZE - sizeof(struct slab)) / cache->object_size) {
        list_del(&s->list);
        list_add_tail(&s->list, &cache->full);
    }
    // Embed slab pointer inside object memory
    // (struct slab **)obj treats obj as a pointer storage location.
	// *(struct slab **)obj = s; writes the slab pointer s at obj's memory.
    //*(struct slab **)obj = s;
    release(&cache->lock);
    //return (char *)obj + sizeof(struct slab *);
    return obj;
}

void kmem_cache_free(struct kmem_cache *cache, void *obj)
{
	// TODO: Implement kmem_cache_free
	/*
	printf("[SLAB] TODO: kmem_cache_free is not yet implemented \n");

	// acquire(&cache->lock); // acquire the lock before modification
	// ... (modify kmem_cache)
	// release(&cache->lock); // release the lock before return
	*/
  	acquire(&cache->lock);
  	//
  	// If the object belongs to kmem_cache itself, return it to freelist
    if ((char *)obj >= (char *)cache && (char *)obj < (char *)cache + PGSIZE) {
        ((struct run *)obj)->next = cache->freelist;
        cache->freelist = (struct run *)obj;
        debug("[SLAB] Free %p in slab %p (%s)\n", obj, cache, cache->name);
        debug("[SLAB] End of free\n");
        release(&cache->lock);
        return;
    }
  	//

  	//struct slab *s = *(struct slab **)((char *)obj - sizeof(struct slab *));
  	struct slab *s = (struct slab *)((uint64)obj & ~(PGSIZE-1));
  	debug("[SLAB] Free %p in slab %p (%s)\n", obj, s, cache->name);

    // Add object back to freelist
    ((struct run *)obj)->next = s->freelist;  // Link freed object to current freelist head
    s->freelist = (struct run *)obj;		  // Update freelist to point to newly freed object
    s->in_use--;

    // Move back to partial list if it was full
    if (s->in_use == (PGSIZE - sizeof(struct slab)) / cache->object_size - 1) {
        list_del(&s->list);
        list_add_tail(&s->list, &cache->partial);
    }

    // Move to free list if empty
    if (s->in_use == 0) {
        list_del(&s->list);
        
        int total_slabs = 0;
        struct slab *tmp;
        list_for_each_entry(tmp, &cache->partial, list) { total_slabs++; }
        list_for_each_entry(tmp, &cache->free, list) { total_slabs++; }

        if (total_slabs >= MP2_MIN_AVAIL_SLAB) {
            debug("[SLAB] slab %p (%s) is freed due to save memory\n", s, cache->name);
            kfree((void *)s);
        } else {
            list_add_tail(&s->list, &cache->free);
        }
    }
    debug("[SLAB] End of free\n");
    release(&cache->lock);
}
