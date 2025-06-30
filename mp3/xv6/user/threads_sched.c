#include "kernel/types.h"
#include "user/user.h"
#include "user/list.h"
#include "user/threads.h"
#include "user/threads_sched.h"
#include <limits.h>
#define NULL 0

/* default scheduling algorithm */
#ifdef THREAD_SCHEDULER_DEFAULT
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    struct thread *thread_with_smallest_id = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
            thread_with_smallest_id = th;
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
        r.allocated_time = thread_with_smallest_id->remaining_time;
    } else {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }

    return r;
}
#endif

/* MP3 Part 1 - Non-Real-Time Scheduling */

// HRRN
#ifdef THREAD_SCHEDULER_HRRN
struct threads_sched_result schedule_hrrn(struct threads_sched_args args)
{
    struct thread *selected = NULL;

    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (th->is_real_time)
            continue;

        int waiting_time = args.current_time - th->arrival_time;
        int burst_time = th->processing_time;

        if (burst_time <= 0)
            continue;

        if (selected == NULL) {
            selected = th;
            continue;
        }

        int w1 = waiting_time;
        int b1 = burst_time;
        int w2 = args.current_time - selected->arrival_time;
        int b2 = selected->processing_time;

        // Compare (w1 + b1) * b2 vs (w2 + b2) * b1
        if ((w1 + b1) * b2 > (w2 + b2) * b1 ||
            ((w1 + b1) * b2 == (w2 + b2) * b1 && th->ID < selected->ID)) {
            selected = th;
        }
    }

    struct threads_sched_result r;
    // TO DO
    if (selected != NULL) {
        r.scheduled_thread_list_member = &selected->thread_list;
        r.allocated_time = selected->remaining_time;  // run non-preemptively
    } else {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }

    return r;
}
#endif

#ifdef THREAD_SCHEDULER_PRIORITY_RR
// priority Round-Robin(RR)
struct threads_sched_result schedule_priority_rr(struct threads_sched_args args) 
{
    struct thread *selected = NULL;
    int highest_priority = 5;
    int count_in_group = 0;

    struct thread *th = NULL;

    // First pass: Find highest priority among non-real-time threads
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (th->is_real_time)
            continue;
        if (th->priority < highest_priority){
            highest_priority = th->priority;
            count_in_group = 1;
        }
        else if (th->priority == highest_priority){
            count_in_group++;
        }
    }

    // Second pass: Select first thread with highest priority (round-robin)
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (th->is_real_time)
            continue;
        if (th->priority == highest_priority) {
            selected = th;
            break;  // pick the first one in round-robin order
        }
    }
    struct threads_sched_result r;
    // TO DO
    if (selected != NULL) {
        int allocated;
        if (count_in_group == 1 || selected->remaining_time <= args.time_quantum) {
            // Run to completion
            allocated = selected->remaining_time;
        } else {
            // Time slice
            allocated = args.time_quantum;

            // Rotate: only if thread will continue after this slice
            list_del(&selected->thread_list);
            list_add_tail(&selected->thread_list, args.run_queue);
        }

        r.scheduled_thread_list_member = &selected->thread_list;
        r.allocated_time = allocated;
    } else {
        r.scheduled_thread_list_member = args.run_queue;  // fallback
        r.allocated_time = 1;
    }

    return r;
}
#endif

/* MP3 Part 2 - Real-Time Scheduling*/

#if defined(THREAD_SCHEDULER_EDF_CBS) || defined(THREAD_SCHEDULER_DM)
static struct thread *__check_deadline_miss(struct list_head *run_queue, int current_time)
{
    struct thread *th = NULL;
    struct thread *thread_missing_deadline = NULL;
    list_for_each_entry(th, run_queue, thread_list) {
        if (th->current_deadline <= current_time) {
            if (thread_missing_deadline == NULL)
                thread_missing_deadline = th;
            else if (th->ID < thread_missing_deadline->ID)
                thread_missing_deadline = th;
        }
    }
    return thread_missing_deadline;
}
#endif

#ifdef THREAD_SCHEDULER_DM
/* Deadline-Monotonic Scheduling */
static int __dm_thread_cmp(struct thread *a, struct thread *b)
{
    //To DO
    if (a->deadline != b->deadline)
        return a->deadline - b->deadline;
    return a->ID - b->ID;
}

struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    struct threads_sched_result r;

    // Release any eligible real-time threads
    int closest_release_time = __INT_MAX__;
    struct release_queue_entry *entry, *tmp;
    list_for_each_entry_safe(entry, tmp, args.release_queue, thread_list) {
        if (entry->release_time <= args.current_time) {
            list_del(&entry->thread_list);
            list_add_tail(&entry->thrd->thread_list, args.run_queue);
        }else{
            if (entry->release_time < closest_release_time){
                closest_release_time = entry->release_time;
            }
        }
    }

    // first check if there is any thread has missed its current deadline
    // TO DO

    struct thread *missed = __check_deadline_miss(args.run_queue, args.current_time);
    if (missed != NULL) {
        // fprintf(1, "a");
        r.scheduled_thread_list_member = &missed->thread_list;
        r.allocated_time = 0;
        return r;
    }

    // handle the case where run queue is empty
    // TO DO
    if (list_empty(args.run_queue)) {
        // fprintf(1, "b");
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = closest_release_time - args.current_time;
        return r;
    }
    // 3. Find the real-time thread with the earliest deadline
    struct thread *selected = NULL;
    struct thread *th;
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (!th->is_real_time)
            continue;

        if (selected == NULL || __dm_thread_cmp(th, selected) < 0)
            selected = th;
    }

    // 4. If no real-time thread found
    if (selected == NULL) {
        // fprintf(1, "c");
        r.scheduled_thread_list_member = args.run_queue;;
        r.allocated_time = 0;
        return r;
    }

    // 5. Allocate time to the thread
    int next_release_time = __INT_MAX__;
    list_for_each_entry(entry, args.release_queue, thread_list) {
        if (entry->release_time < next_release_time)
            next_release_time = entry->release_time;
    }

    int deadline_gap = selected->current_deadline - args.current_time;
    int preempt_gap = next_release_time - args.current_time;

    int safe_alloc = selected->remaining_time;
    if (deadline_gap < safe_alloc) safe_alloc = deadline_gap;
    if (preempt_gap < safe_alloc) safe_alloc = preempt_gap;

    // Ensure safe_alloc is not negative
    if (safe_alloc <= 0) {
        r.scheduled_thread_list_member = &selected->thread_list;
        r.allocated_time = 0;
    } else {
        r.scheduled_thread_list_member = &selected->thread_list;
        r.allocated_time = safe_alloc;
    }
    // fprintf(1, "d");
    return r;
}
#endif


#ifdef THREAD_SCHEDULER_EDF_CBS
// EDF with CBS comparation
static int __edf_thread_cmp(struct thread *a, struct thread *b)
{
    // TO DO
}
//  EDF_CBS scheduler
struct threads_sched_result schedule_edf_cbs(struct threads_sched_args args)
{
    struct threads_sched_result r;

    // notify the throttle task
    // TO DO

    // first check if there is any thread has missed its current deadline
    // TO DO

    // handle the case where run queue is empty
    // TO DO

    return r;
}
#endif