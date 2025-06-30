#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "printfslab.h"
#include "param.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"

void printfslab(void)
{
  print_kmem_cache(file_cache, fileprint_metadata);
}

uint64
sys_printfslab(void)
{
  printfslab();
  return 0;
}