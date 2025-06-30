#pragma once

#include <stdarg.h>
#include "defs.h"
/**
 * printslab - Print the slab information
 *
 * Toggles the current debug mode between %OFF and %ON states.
 * This function does not take any parameters and has no return value.
 */
void printfslab(void);
/**
 * sys_printslab - System call to print the slab information
 *
 * Provides the system call interface to toggle the debug mode.
 * This function is intended to be invoked via a syscall mechanism.
 *
 * Return: 0 on success, or an error code on failure
 */
uint64 sys_printfslab(void);