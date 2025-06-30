# 2025-Spring-OS-MP

This repo is about the Machine Problem of NTU OS 113-2.

**❗️Disclaimer❗️**: This work did not receive full marks, and some parts of the assignment were incomplete. The contents of this repository are provided for reference purposes only. Plagiarism is strictly discouraged.

## MP0 - xv6 Setup
- Launching xv6
- tree command & mp0 command 

## MP1 - Thread Package
- Part 1:
    - thread add runqueue 
    - thread yield
    - dispatch
    - schedule
    - thread exit
    - thread start threading
- Part 2:
    - thread suspend
    - thread resume
    - thread kill

## MP2 - Memory management: Kernel Memory Allocation (slab)
- Implementing the slab Allocator

## MP3 - Scheduling
- Part 1 - None Real-time scheduling:
    - Highest Response RatioNext(HRRN) 
    - Priority-based Round Robin(P-RR) 
- Part 2 - Real Time Scheduling:
    - Deadline-MonotonicScheduling
    - Earliest Deadline First (EDF) with Constant Bandwidth Server (CBS) scheduling

## MP4 - File System
- Part 1 - Access Control & Symbolic links:
    - symln 
    - chmod & Access Control
    - ls
    - `open` mode check
- Part 2 - RAID 1 Simulation:
    - Mirrored Writes
    - Write Fallback logic
    - Read Fallback Logic