
user/_rttask5:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <f>:
#define NULL 0

int k = 0;

void f(void *arg)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec22                	sd	s0,24(sp)
       4:	1000                	addi	s0,sp,32
       6:	fea43423          	sd	a0,-24(s0)
    while (1) {
        k++;
       a:	00002797          	auipc	a5,0x2
       e:	24678793          	addi	a5,a5,582 # 2250 <k>
      12:	439c                	lw	a5,0(a5)
      14:	2785                	addiw	a5,a5,1
      16:	0007871b          	sext.w	a4,a5
      1a:	00002797          	auipc	a5,0x2
      1e:	23678793          	addi	a5,a5,566 # 2250 <k>
      22:	c398                	sw	a4,0(a5)
      24:	b7dd                	j	a <f+0xa>

0000000000000026 <main>:
    }
}

int main(int argc, char **argv)
{
      26:	715d                	addi	sp,sp,-80
      28:	e486                	sd	ra,72(sp)
      2a:	e0a2                	sd	s0,64(sp)
      2c:	0880                	addi	s0,sp,80
      2e:	87aa                	mv	a5,a0
      30:	fab43823          	sd	a1,-80(s0)
      34:	faf42e23          	sw	a5,-68(s0)
    if (argc < 2) {
      38:	fbc42783          	lw	a5,-68(s0)
      3c:	0007871b          	sext.w	a4,a5
      40:	4785                	li	a5,1
      42:	02e7c063          	blt	a5,a4,62 <main+0x3c>
        fprintf(2, "Usage: rttask1 [EDF_CBS|DM]\n");
      46:	00002597          	auipc	a1,0x2
      4a:	00a58593          	addi	a1,a1,10 # 2050 <schedule_dm+0x2e0>
      4e:	4509                	li	a0,2
      50:	00001097          	auipc	ra,0x1
      54:	aec080e7          	jalr	-1300(ra) # b3c <fprintf>
        exit(1);
      58:	4505                	li	a0,1
      5a:	00000097          	auipc	ra,0x0
      5e:	5f4080e7          	jalr	1524(ra) # 64e <exit>
    }

    if (strcmp(argv[1], "EDF_CBS") == 0) {
      62:	fb043783          	ld	a5,-80(s0)
      66:	07a1                	addi	a5,a5,8
      68:	639c                	ld	a5,0(a5)
      6a:	00002597          	auipc	a1,0x2
      6e:	00658593          	addi	a1,a1,6 # 2070 <schedule_dm+0x300>
      72:	853e                	mv	a0,a5
      74:	00000097          	auipc	ra,0x0
      78:	194080e7          	jalr	404(ra) # 208 <strcmp>
      7c:	87aa                	mv	a5,a0
      7e:	efb5                	bnez	a5,fa <main+0xd4>
        struct thread *t1 = thread_create(f, NULL, 1, 7, 22, 2);
      80:	4789                	li	a5,2
      82:	4759                	li	a4,22
      84:	469d                	li	a3,7
      86:	4605                	li	a2,1
      88:	4581                	li	a1,0
      8a:	00000517          	auipc	a0,0x0
      8e:	f7650513          	addi	a0,a0,-138 # 0 <f>
      92:	00001097          	auipc	ra,0x1
      96:	fba080e7          	jalr	-70(ra) # 104c <thread_create>
      9a:	fca43823          	sd	a0,-48(s0)
        init_thread_cbs(t1, 7, 1);
      9e:	4605                	li	a2,1
      a0:	459d                	li	a1,7
      a2:	fd043503          	ld	a0,-48(s0)
      a6:	00001097          	auipc	ra,0x1
      aa:	0e0080e7          	jalr	224(ra) # 1186 <init_thread_cbs>
        thread_add_at(t1, 0);
      ae:	4581                	li	a1,0
      b0:	fd043503          	ld	a0,-48(s0)
      b4:	00001097          	auipc	ra,0x1
      b8:	128080e7          	jalr	296(ra) # 11dc <thread_add_at>

        struct thread *t4 = thread_create(f, NULL, 1, 8, 10, 2);
      bc:	4789                	li	a5,2
      be:	4729                	li	a4,10
      c0:	46a1                	li	a3,8
      c2:	4605                	li	a2,1
      c4:	4581                	li	a1,0
      c6:	00000517          	auipc	a0,0x0
      ca:	f3a50513          	addi	a0,a0,-198 # 0 <f>
      ce:	00001097          	auipc	ra,0x1
      d2:	f7e080e7          	jalr	-130(ra) # 104c <thread_create>
      d6:	fca43423          	sd	a0,-56(s0)
        init_thread_cbs(t4, 5, 0);
      da:	4601                	li	a2,0
      dc:	4595                	li	a1,5
      de:	fc843503          	ld	a0,-56(s0)
      e2:	00001097          	auipc	ra,0x1
      e6:	0a4080e7          	jalr	164(ra) # 1186 <init_thread_cbs>
        thread_add_at(t4, 0);
      ea:	4581                	li	a1,0
      ec:	fc843503          	ld	a0,-56(s0)
      f0:	00001097          	auipc	ra,0x1
      f4:	0ec080e7          	jalr	236(ra) # 11dc <thread_add_at>
      f8:	a055                	j	19c <main+0x176>

    } else if (strcmp(argv[1], "DM") == 0) {
      fa:	fb043783          	ld	a5,-80(s0)
      fe:	07a1                	addi	a5,a5,8
     100:	639c                	ld	a5,0(a5)
     102:	00002597          	auipc	a1,0x2
     106:	f7658593          	addi	a1,a1,-138 # 2078 <schedule_dm+0x308>
     10a:	853e                	mv	a0,a5
     10c:	00000097          	auipc	ra,0x0
     110:	0fc080e7          	jalr	252(ra) # 208 <strcmp>
     114:	87aa                	mv	a5,a0
     116:	e3d9                	bnez	a5,19c <main+0x176>
        struct thread *t1 = thread_create(f, NULL, 1, 3, 9, 2);
     118:	4789                	li	a5,2
     11a:	4725                	li	a4,9
     11c:	468d                	li	a3,3
     11e:	4605                	li	a2,1
     120:	4581                	li	a1,0
     122:	00000517          	auipc	a0,0x0
     126:	ede50513          	addi	a0,a0,-290 # 0 <f>
     12a:	00001097          	auipc	ra,0x1
     12e:	f22080e7          	jalr	-222(ra) # 104c <thread_create>
     132:	fea43423          	sd	a0,-24(s0)
        thread_add_at(t1, 2);
     136:	4589                	li	a1,2
     138:	fe843503          	ld	a0,-24(s0)
     13c:	00001097          	auipc	ra,0x1
     140:	0a0080e7          	jalr	160(ra) # 11dc <thread_add_at>

        struct thread *t2 = thread_create(f, NULL, 1, 5, 15, 2);
     144:	4789                	li	a5,2
     146:	473d                	li	a4,15
     148:	4695                	li	a3,5
     14a:	4605                	li	a2,1
     14c:	4581                	li	a1,0
     14e:	00000517          	auipc	a0,0x0
     152:	eb250513          	addi	a0,a0,-334 # 0 <f>
     156:	00001097          	auipc	ra,0x1
     15a:	ef6080e7          	jalr	-266(ra) # 104c <thread_create>
     15e:	fea43023          	sd	a0,-32(s0)
        thread_add_at(t2, 0);
     162:	4581                	li	a1,0
     164:	fe043503          	ld	a0,-32(s0)
     168:	00001097          	auipc	ra,0x1
     16c:	074080e7          	jalr	116(ra) # 11dc <thread_add_at>

        struct thread *t3 = thread_create(f, NULL, 1, 3, 9, 2);
     170:	4789                	li	a5,2
     172:	4725                	li	a4,9
     174:	468d                	li	a3,3
     176:	4605                	li	a2,1
     178:	4581                	li	a1,0
     17a:	00000517          	auipc	a0,0x0
     17e:	e8650513          	addi	a0,a0,-378 # 0 <f>
     182:	00001097          	auipc	ra,0x1
     186:	eca080e7          	jalr	-310(ra) # 104c <thread_create>
     18a:	fca43c23          	sd	a0,-40(s0)
        thread_add_at(t3, 1);
     18e:	4585                	li	a1,1
     190:	fd843503          	ld	a0,-40(s0)
     194:	00001097          	auipc	ra,0x1
     198:	048080e7          	jalr	72(ra) # 11dc <thread_add_at>
        }

    thread_start_threading();
     19c:	00002097          	auipc	ra,0x2
     1a0:	88a080e7          	jalr	-1910(ra) # 1a26 <thread_start_threading>
    printf("\nexited\n");
     1a4:	00002517          	auipc	a0,0x2
     1a8:	edc50513          	addi	a0,a0,-292 # 2080 <schedule_dm+0x310>
     1ac:	00001097          	auipc	ra,0x1
     1b0:	9e8080e7          	jalr	-1560(ra) # b94 <printf>
    exit(0);
     1b4:	4501                	li	a0,0
     1b6:	00000097          	auipc	ra,0x0
     1ba:	498080e7          	jalr	1176(ra) # 64e <exit>

00000000000001be <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     1be:	7179                	addi	sp,sp,-48
     1c0:	f422                	sd	s0,40(sp)
     1c2:	1800                	addi	s0,sp,48
     1c4:	fca43c23          	sd	a0,-40(s0)
     1c8:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     1cc:	fd843783          	ld	a5,-40(s0)
     1d0:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     1d4:	0001                	nop
     1d6:	fd043703          	ld	a4,-48(s0)
     1da:	00170793          	addi	a5,a4,1
     1de:	fcf43823          	sd	a5,-48(s0)
     1e2:	fd843783          	ld	a5,-40(s0)
     1e6:	00178693          	addi	a3,a5,1
     1ea:	fcd43c23          	sd	a3,-40(s0)
     1ee:	00074703          	lbu	a4,0(a4)
     1f2:	00e78023          	sb	a4,0(a5)
     1f6:	0007c783          	lbu	a5,0(a5)
     1fa:	fff1                	bnez	a5,1d6 <strcpy+0x18>
    ;
  return os;
     1fc:	fe843783          	ld	a5,-24(s0)
}
     200:	853e                	mv	a0,a5
     202:	7422                	ld	s0,40(sp)
     204:	6145                	addi	sp,sp,48
     206:	8082                	ret

0000000000000208 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     208:	1101                	addi	sp,sp,-32
     20a:	ec22                	sd	s0,24(sp)
     20c:	1000                	addi	s0,sp,32
     20e:	fea43423          	sd	a0,-24(s0)
     212:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     216:	a819                	j	22c <strcmp+0x24>
    p++, q++;
     218:	fe843783          	ld	a5,-24(s0)
     21c:	0785                	addi	a5,a5,1
     21e:	fef43423          	sd	a5,-24(s0)
     222:	fe043783          	ld	a5,-32(s0)
     226:	0785                	addi	a5,a5,1
     228:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     22c:	fe843783          	ld	a5,-24(s0)
     230:	0007c783          	lbu	a5,0(a5)
     234:	cb99                	beqz	a5,24a <strcmp+0x42>
     236:	fe843783          	ld	a5,-24(s0)
     23a:	0007c703          	lbu	a4,0(a5)
     23e:	fe043783          	ld	a5,-32(s0)
     242:	0007c783          	lbu	a5,0(a5)
     246:	fcf709e3          	beq	a4,a5,218 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     24a:	fe843783          	ld	a5,-24(s0)
     24e:	0007c783          	lbu	a5,0(a5)
     252:	0007871b          	sext.w	a4,a5
     256:	fe043783          	ld	a5,-32(s0)
     25a:	0007c783          	lbu	a5,0(a5)
     25e:	2781                	sext.w	a5,a5
     260:	40f707bb          	subw	a5,a4,a5
     264:	2781                	sext.w	a5,a5
}
     266:	853e                	mv	a0,a5
     268:	6462                	ld	s0,24(sp)
     26a:	6105                	addi	sp,sp,32
     26c:	8082                	ret

000000000000026e <strlen>:

uint
strlen(const char *s)
{
     26e:	7179                	addi	sp,sp,-48
     270:	f422                	sd	s0,40(sp)
     272:	1800                	addi	s0,sp,48
     274:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     278:	fe042623          	sw	zero,-20(s0)
     27c:	a031                	j	288 <strlen+0x1a>
     27e:	fec42783          	lw	a5,-20(s0)
     282:	2785                	addiw	a5,a5,1
     284:	fef42623          	sw	a5,-20(s0)
     288:	fec42783          	lw	a5,-20(s0)
     28c:	fd843703          	ld	a4,-40(s0)
     290:	97ba                	add	a5,a5,a4
     292:	0007c783          	lbu	a5,0(a5)
     296:	f7e5                	bnez	a5,27e <strlen+0x10>
    ;
  return n;
     298:	fec42783          	lw	a5,-20(s0)
}
     29c:	853e                	mv	a0,a5
     29e:	7422                	ld	s0,40(sp)
     2a0:	6145                	addi	sp,sp,48
     2a2:	8082                	ret

00000000000002a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
     2a4:	7179                	addi	sp,sp,-48
     2a6:	f422                	sd	s0,40(sp)
     2a8:	1800                	addi	s0,sp,48
     2aa:	fca43c23          	sd	a0,-40(s0)
     2ae:	87ae                	mv	a5,a1
     2b0:	8732                	mv	a4,a2
     2b2:	fcf42a23          	sw	a5,-44(s0)
     2b6:	87ba                	mv	a5,a4
     2b8:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     2bc:	fd843783          	ld	a5,-40(s0)
     2c0:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     2c4:	fe042623          	sw	zero,-20(s0)
     2c8:	a00d                	j	2ea <memset+0x46>
    cdst[i] = c;
     2ca:	fec42783          	lw	a5,-20(s0)
     2ce:	fe043703          	ld	a4,-32(s0)
     2d2:	97ba                	add	a5,a5,a4
     2d4:	fd442703          	lw	a4,-44(s0)
     2d8:	0ff77713          	andi	a4,a4,255
     2dc:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     2e0:	fec42783          	lw	a5,-20(s0)
     2e4:	2785                	addiw	a5,a5,1
     2e6:	fef42623          	sw	a5,-20(s0)
     2ea:	fec42703          	lw	a4,-20(s0)
     2ee:	fd042783          	lw	a5,-48(s0)
     2f2:	2781                	sext.w	a5,a5
     2f4:	fcf76be3          	bltu	a4,a5,2ca <memset+0x26>
  }
  return dst;
     2f8:	fd843783          	ld	a5,-40(s0)
}
     2fc:	853e                	mv	a0,a5
     2fe:	7422                	ld	s0,40(sp)
     300:	6145                	addi	sp,sp,48
     302:	8082                	ret

0000000000000304 <strchr>:

char*
strchr(const char *s, char c)
{
     304:	1101                	addi	sp,sp,-32
     306:	ec22                	sd	s0,24(sp)
     308:	1000                	addi	s0,sp,32
     30a:	fea43423          	sd	a0,-24(s0)
     30e:	87ae                	mv	a5,a1
     310:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     314:	a01d                	j	33a <strchr+0x36>
    if(*s == c)
     316:	fe843783          	ld	a5,-24(s0)
     31a:	0007c703          	lbu	a4,0(a5)
     31e:	fe744783          	lbu	a5,-25(s0)
     322:	0ff7f793          	andi	a5,a5,255
     326:	00e79563          	bne	a5,a4,330 <strchr+0x2c>
      return (char*)s;
     32a:	fe843783          	ld	a5,-24(s0)
     32e:	a821                	j	346 <strchr+0x42>
  for(; *s; s++)
     330:	fe843783          	ld	a5,-24(s0)
     334:	0785                	addi	a5,a5,1
     336:	fef43423          	sd	a5,-24(s0)
     33a:	fe843783          	ld	a5,-24(s0)
     33e:	0007c783          	lbu	a5,0(a5)
     342:	fbf1                	bnez	a5,316 <strchr+0x12>
  return 0;
     344:	4781                	li	a5,0
}
     346:	853e                	mv	a0,a5
     348:	6462                	ld	s0,24(sp)
     34a:	6105                	addi	sp,sp,32
     34c:	8082                	ret

000000000000034e <gets>:

char*
gets(char *buf, int max)
{
     34e:	7179                	addi	sp,sp,-48
     350:	f406                	sd	ra,40(sp)
     352:	f022                	sd	s0,32(sp)
     354:	1800                	addi	s0,sp,48
     356:	fca43c23          	sd	a0,-40(s0)
     35a:	87ae                	mv	a5,a1
     35c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     360:	fe042623          	sw	zero,-20(s0)
     364:	a8a1                	j	3bc <gets+0x6e>
    cc = read(0, &c, 1);
     366:	fe740793          	addi	a5,s0,-25
     36a:	4605                	li	a2,1
     36c:	85be                	mv	a1,a5
     36e:	4501                	li	a0,0
     370:	00000097          	auipc	ra,0x0
     374:	2f6080e7          	jalr	758(ra) # 666 <read>
     378:	87aa                	mv	a5,a0
     37a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     37e:	fe842783          	lw	a5,-24(s0)
     382:	2781                	sext.w	a5,a5
     384:	04f05763          	blez	a5,3d2 <gets+0x84>
      break;
    buf[i++] = c;
     388:	fec42783          	lw	a5,-20(s0)
     38c:	0017871b          	addiw	a4,a5,1
     390:	fee42623          	sw	a4,-20(s0)
     394:	873e                	mv	a4,a5
     396:	fd843783          	ld	a5,-40(s0)
     39a:	97ba                	add	a5,a5,a4
     39c:	fe744703          	lbu	a4,-25(s0)
     3a0:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     3a4:	fe744783          	lbu	a5,-25(s0)
     3a8:	873e                	mv	a4,a5
     3aa:	47a9                	li	a5,10
     3ac:	02f70463          	beq	a4,a5,3d4 <gets+0x86>
     3b0:	fe744783          	lbu	a5,-25(s0)
     3b4:	873e                	mv	a4,a5
     3b6:	47b5                	li	a5,13
     3b8:	00f70e63          	beq	a4,a5,3d4 <gets+0x86>
  for(i=0; i+1 < max; ){
     3bc:	fec42783          	lw	a5,-20(s0)
     3c0:	2785                	addiw	a5,a5,1
     3c2:	0007871b          	sext.w	a4,a5
     3c6:	fd442783          	lw	a5,-44(s0)
     3ca:	2781                	sext.w	a5,a5
     3cc:	f8f74de3          	blt	a4,a5,366 <gets+0x18>
     3d0:	a011                	j	3d4 <gets+0x86>
      break;
     3d2:	0001                	nop
      break;
  }
  buf[i] = '\0';
     3d4:	fec42783          	lw	a5,-20(s0)
     3d8:	fd843703          	ld	a4,-40(s0)
     3dc:	97ba                	add	a5,a5,a4
     3de:	00078023          	sb	zero,0(a5)
  return buf;
     3e2:	fd843783          	ld	a5,-40(s0)
}
     3e6:	853e                	mv	a0,a5
     3e8:	70a2                	ld	ra,40(sp)
     3ea:	7402                	ld	s0,32(sp)
     3ec:	6145                	addi	sp,sp,48
     3ee:	8082                	ret

00000000000003f0 <stat>:

int
stat(const char *n, struct stat *st)
{
     3f0:	7179                	addi	sp,sp,-48
     3f2:	f406                	sd	ra,40(sp)
     3f4:	f022                	sd	s0,32(sp)
     3f6:	1800                	addi	s0,sp,48
     3f8:	fca43c23          	sd	a0,-40(s0)
     3fc:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     400:	4581                	li	a1,0
     402:	fd843503          	ld	a0,-40(s0)
     406:	00000097          	auipc	ra,0x0
     40a:	288080e7          	jalr	648(ra) # 68e <open>
     40e:	87aa                	mv	a5,a0
     410:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     414:	fec42783          	lw	a5,-20(s0)
     418:	2781                	sext.w	a5,a5
     41a:	0007d463          	bgez	a5,422 <stat+0x32>
    return -1;
     41e:	57fd                	li	a5,-1
     420:	a035                	j	44c <stat+0x5c>
  r = fstat(fd, st);
     422:	fec42783          	lw	a5,-20(s0)
     426:	fd043583          	ld	a1,-48(s0)
     42a:	853e                	mv	a0,a5
     42c:	00000097          	auipc	ra,0x0
     430:	27a080e7          	jalr	634(ra) # 6a6 <fstat>
     434:	87aa                	mv	a5,a0
     436:	fef42423          	sw	a5,-24(s0)
  close(fd);
     43a:	fec42783          	lw	a5,-20(s0)
     43e:	853e                	mv	a0,a5
     440:	00000097          	auipc	ra,0x0
     444:	236080e7          	jalr	566(ra) # 676 <close>
  return r;
     448:	fe842783          	lw	a5,-24(s0)
}
     44c:	853e                	mv	a0,a5
     44e:	70a2                	ld	ra,40(sp)
     450:	7402                	ld	s0,32(sp)
     452:	6145                	addi	sp,sp,48
     454:	8082                	ret

0000000000000456 <atoi>:

int
atoi(const char *s)
{
     456:	7179                	addi	sp,sp,-48
     458:	f422                	sd	s0,40(sp)
     45a:	1800                	addi	s0,sp,48
     45c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     460:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     464:	a815                	j	498 <atoi+0x42>
    n = n*10 + *s++ - '0';
     466:	fec42703          	lw	a4,-20(s0)
     46a:	87ba                	mv	a5,a4
     46c:	0027979b          	slliw	a5,a5,0x2
     470:	9fb9                	addw	a5,a5,a4
     472:	0017979b          	slliw	a5,a5,0x1
     476:	0007871b          	sext.w	a4,a5
     47a:	fd843783          	ld	a5,-40(s0)
     47e:	00178693          	addi	a3,a5,1
     482:	fcd43c23          	sd	a3,-40(s0)
     486:	0007c783          	lbu	a5,0(a5)
     48a:	2781                	sext.w	a5,a5
     48c:	9fb9                	addw	a5,a5,a4
     48e:	2781                	sext.w	a5,a5
     490:	fd07879b          	addiw	a5,a5,-48
     494:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     498:	fd843783          	ld	a5,-40(s0)
     49c:	0007c783          	lbu	a5,0(a5)
     4a0:	873e                	mv	a4,a5
     4a2:	02f00793          	li	a5,47
     4a6:	00e7fb63          	bgeu	a5,a4,4bc <atoi+0x66>
     4aa:	fd843783          	ld	a5,-40(s0)
     4ae:	0007c783          	lbu	a5,0(a5)
     4b2:	873e                	mv	a4,a5
     4b4:	03900793          	li	a5,57
     4b8:	fae7f7e3          	bgeu	a5,a4,466 <atoi+0x10>
  return n;
     4bc:	fec42783          	lw	a5,-20(s0)
}
     4c0:	853e                	mv	a0,a5
     4c2:	7422                	ld	s0,40(sp)
     4c4:	6145                	addi	sp,sp,48
     4c6:	8082                	ret

00000000000004c8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     4c8:	7139                	addi	sp,sp,-64
     4ca:	fc22                	sd	s0,56(sp)
     4cc:	0080                	addi	s0,sp,64
     4ce:	fca43c23          	sd	a0,-40(s0)
     4d2:	fcb43823          	sd	a1,-48(s0)
     4d6:	87b2                	mv	a5,a2
     4d8:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     4dc:	fd843783          	ld	a5,-40(s0)
     4e0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     4e4:	fd043783          	ld	a5,-48(s0)
     4e8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     4ec:	fe043703          	ld	a4,-32(s0)
     4f0:	fe843783          	ld	a5,-24(s0)
     4f4:	02e7fc63          	bgeu	a5,a4,52c <memmove+0x64>
    while(n-- > 0)
     4f8:	a00d                	j	51a <memmove+0x52>
      *dst++ = *src++;
     4fa:	fe043703          	ld	a4,-32(s0)
     4fe:	00170793          	addi	a5,a4,1
     502:	fef43023          	sd	a5,-32(s0)
     506:	fe843783          	ld	a5,-24(s0)
     50a:	00178693          	addi	a3,a5,1
     50e:	fed43423          	sd	a3,-24(s0)
     512:	00074703          	lbu	a4,0(a4)
     516:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     51a:	fcc42783          	lw	a5,-52(s0)
     51e:	fff7871b          	addiw	a4,a5,-1
     522:	fce42623          	sw	a4,-52(s0)
     526:	fcf04ae3          	bgtz	a5,4fa <memmove+0x32>
     52a:	a891                	j	57e <memmove+0xb6>
  } else {
    dst += n;
     52c:	fcc42783          	lw	a5,-52(s0)
     530:	fe843703          	ld	a4,-24(s0)
     534:	97ba                	add	a5,a5,a4
     536:	fef43423          	sd	a5,-24(s0)
    src += n;
     53a:	fcc42783          	lw	a5,-52(s0)
     53e:	fe043703          	ld	a4,-32(s0)
     542:	97ba                	add	a5,a5,a4
     544:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     548:	a01d                	j	56e <memmove+0xa6>
      *--dst = *--src;
     54a:	fe043783          	ld	a5,-32(s0)
     54e:	17fd                	addi	a5,a5,-1
     550:	fef43023          	sd	a5,-32(s0)
     554:	fe843783          	ld	a5,-24(s0)
     558:	17fd                	addi	a5,a5,-1
     55a:	fef43423          	sd	a5,-24(s0)
     55e:	fe043783          	ld	a5,-32(s0)
     562:	0007c703          	lbu	a4,0(a5)
     566:	fe843783          	ld	a5,-24(s0)
     56a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     56e:	fcc42783          	lw	a5,-52(s0)
     572:	fff7871b          	addiw	a4,a5,-1
     576:	fce42623          	sw	a4,-52(s0)
     57a:	fcf048e3          	bgtz	a5,54a <memmove+0x82>
  }
  return vdst;
     57e:	fd843783          	ld	a5,-40(s0)
}
     582:	853e                	mv	a0,a5
     584:	7462                	ld	s0,56(sp)
     586:	6121                	addi	sp,sp,64
     588:	8082                	ret

000000000000058a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     58a:	7139                	addi	sp,sp,-64
     58c:	fc22                	sd	s0,56(sp)
     58e:	0080                	addi	s0,sp,64
     590:	fca43c23          	sd	a0,-40(s0)
     594:	fcb43823          	sd	a1,-48(s0)
     598:	87b2                	mv	a5,a2
     59a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     59e:	fd843783          	ld	a5,-40(s0)
     5a2:	fef43423          	sd	a5,-24(s0)
     5a6:	fd043783          	ld	a5,-48(s0)
     5aa:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5ae:	a0a1                	j	5f6 <memcmp+0x6c>
    if (*p1 != *p2) {
     5b0:	fe843783          	ld	a5,-24(s0)
     5b4:	0007c703          	lbu	a4,0(a5)
     5b8:	fe043783          	ld	a5,-32(s0)
     5bc:	0007c783          	lbu	a5,0(a5)
     5c0:	02f70163          	beq	a4,a5,5e2 <memcmp+0x58>
      return *p1 - *p2;
     5c4:	fe843783          	ld	a5,-24(s0)
     5c8:	0007c783          	lbu	a5,0(a5)
     5cc:	0007871b          	sext.w	a4,a5
     5d0:	fe043783          	ld	a5,-32(s0)
     5d4:	0007c783          	lbu	a5,0(a5)
     5d8:	2781                	sext.w	a5,a5
     5da:	40f707bb          	subw	a5,a4,a5
     5de:	2781                	sext.w	a5,a5
     5e0:	a01d                	j	606 <memcmp+0x7c>
    }
    p1++;
     5e2:	fe843783          	ld	a5,-24(s0)
     5e6:	0785                	addi	a5,a5,1
     5e8:	fef43423          	sd	a5,-24(s0)
    p2++;
     5ec:	fe043783          	ld	a5,-32(s0)
     5f0:	0785                	addi	a5,a5,1
     5f2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5f6:	fcc42783          	lw	a5,-52(s0)
     5fa:	fff7871b          	addiw	a4,a5,-1
     5fe:	fce42623          	sw	a4,-52(s0)
     602:	f7dd                	bnez	a5,5b0 <memcmp+0x26>
  }
  return 0;
     604:	4781                	li	a5,0
}
     606:	853e                	mv	a0,a5
     608:	7462                	ld	s0,56(sp)
     60a:	6121                	addi	sp,sp,64
     60c:	8082                	ret

000000000000060e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     60e:	7179                	addi	sp,sp,-48
     610:	f406                	sd	ra,40(sp)
     612:	f022                	sd	s0,32(sp)
     614:	1800                	addi	s0,sp,48
     616:	fea43423          	sd	a0,-24(s0)
     61a:	feb43023          	sd	a1,-32(s0)
     61e:	87b2                	mv	a5,a2
     620:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     624:	fdc42783          	lw	a5,-36(s0)
     628:	863e                	mv	a2,a5
     62a:	fe043583          	ld	a1,-32(s0)
     62e:	fe843503          	ld	a0,-24(s0)
     632:	00000097          	auipc	ra,0x0
     636:	e96080e7          	jalr	-362(ra) # 4c8 <memmove>
     63a:	87aa                	mv	a5,a0
}
     63c:	853e                	mv	a0,a5
     63e:	70a2                	ld	ra,40(sp)
     640:	7402                	ld	s0,32(sp)
     642:	6145                	addi	sp,sp,48
     644:	8082                	ret

0000000000000646 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     646:	4885                	li	a7,1
 ecall
     648:	00000073          	ecall
 ret
     64c:	8082                	ret

000000000000064e <exit>:
.global exit
exit:
 li a7, SYS_exit
     64e:	4889                	li	a7,2
 ecall
     650:	00000073          	ecall
 ret
     654:	8082                	ret

0000000000000656 <wait>:
.global wait
wait:
 li a7, SYS_wait
     656:	488d                	li	a7,3
 ecall
     658:	00000073          	ecall
 ret
     65c:	8082                	ret

000000000000065e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     65e:	4891                	li	a7,4
 ecall
     660:	00000073          	ecall
 ret
     664:	8082                	ret

0000000000000666 <read>:
.global read
read:
 li a7, SYS_read
     666:	4895                	li	a7,5
 ecall
     668:	00000073          	ecall
 ret
     66c:	8082                	ret

000000000000066e <write>:
.global write
write:
 li a7, SYS_write
     66e:	48c1                	li	a7,16
 ecall
     670:	00000073          	ecall
 ret
     674:	8082                	ret

0000000000000676 <close>:
.global close
close:
 li a7, SYS_close
     676:	48d5                	li	a7,21
 ecall
     678:	00000073          	ecall
 ret
     67c:	8082                	ret

000000000000067e <kill>:
.global kill
kill:
 li a7, SYS_kill
     67e:	4899                	li	a7,6
 ecall
     680:	00000073          	ecall
 ret
     684:	8082                	ret

0000000000000686 <exec>:
.global exec
exec:
 li a7, SYS_exec
     686:	489d                	li	a7,7
 ecall
     688:	00000073          	ecall
 ret
     68c:	8082                	ret

000000000000068e <open>:
.global open
open:
 li a7, SYS_open
     68e:	48bd                	li	a7,15
 ecall
     690:	00000073          	ecall
 ret
     694:	8082                	ret

0000000000000696 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     696:	48c5                	li	a7,17
 ecall
     698:	00000073          	ecall
 ret
     69c:	8082                	ret

000000000000069e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     69e:	48c9                	li	a7,18
 ecall
     6a0:	00000073          	ecall
 ret
     6a4:	8082                	ret

00000000000006a6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     6a6:	48a1                	li	a7,8
 ecall
     6a8:	00000073          	ecall
 ret
     6ac:	8082                	ret

00000000000006ae <link>:
.global link
link:
 li a7, SYS_link
     6ae:	48cd                	li	a7,19
 ecall
     6b0:	00000073          	ecall
 ret
     6b4:	8082                	ret

00000000000006b6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     6b6:	48d1                	li	a7,20
 ecall
     6b8:	00000073          	ecall
 ret
     6bc:	8082                	ret

00000000000006be <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     6be:	48a5                	li	a7,9
 ecall
     6c0:	00000073          	ecall
 ret
     6c4:	8082                	ret

00000000000006c6 <dup>:
.global dup
dup:
 li a7, SYS_dup
     6c6:	48a9                	li	a7,10
 ecall
     6c8:	00000073          	ecall
 ret
     6cc:	8082                	ret

00000000000006ce <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     6ce:	48ad                	li	a7,11
 ecall
     6d0:	00000073          	ecall
 ret
     6d4:	8082                	ret

00000000000006d6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     6d6:	48b1                	li	a7,12
 ecall
     6d8:	00000073          	ecall
 ret
     6dc:	8082                	ret

00000000000006de <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     6de:	48b5                	li	a7,13
 ecall
     6e0:	00000073          	ecall
 ret
     6e4:	8082                	ret

00000000000006e6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     6e6:	48b9                	li	a7,14
 ecall
     6e8:	00000073          	ecall
 ret
     6ec:	8082                	ret

00000000000006ee <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     6ee:	48d9                	li	a7,22
 ecall
     6f0:	00000073          	ecall
 ret
     6f4:	8082                	ret

00000000000006f6 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     6f6:	48dd                	li	a7,23
 ecall
     6f8:	00000073          	ecall
 ret
     6fc:	8082                	ret

00000000000006fe <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     6fe:	48e1                	li	a7,24
 ecall
     700:	00000073          	ecall
 ret
     704:	8082                	ret

0000000000000706 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     706:	1101                	addi	sp,sp,-32
     708:	ec06                	sd	ra,24(sp)
     70a:	e822                	sd	s0,16(sp)
     70c:	1000                	addi	s0,sp,32
     70e:	87aa                	mv	a5,a0
     710:	872e                	mv	a4,a1
     712:	fef42623          	sw	a5,-20(s0)
     716:	87ba                	mv	a5,a4
     718:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     71c:	feb40713          	addi	a4,s0,-21
     720:	fec42783          	lw	a5,-20(s0)
     724:	4605                	li	a2,1
     726:	85ba                	mv	a1,a4
     728:	853e                	mv	a0,a5
     72a:	00000097          	auipc	ra,0x0
     72e:	f44080e7          	jalr	-188(ra) # 66e <write>
}
     732:	0001                	nop
     734:	60e2                	ld	ra,24(sp)
     736:	6442                	ld	s0,16(sp)
     738:	6105                	addi	sp,sp,32
     73a:	8082                	ret

000000000000073c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     73c:	7139                	addi	sp,sp,-64
     73e:	fc06                	sd	ra,56(sp)
     740:	f822                	sd	s0,48(sp)
     742:	0080                	addi	s0,sp,64
     744:	87aa                	mv	a5,a0
     746:	8736                	mv	a4,a3
     748:	fcf42623          	sw	a5,-52(s0)
     74c:	87ae                	mv	a5,a1
     74e:	fcf42423          	sw	a5,-56(s0)
     752:	87b2                	mv	a5,a2
     754:	fcf42223          	sw	a5,-60(s0)
     758:	87ba                	mv	a5,a4
     75a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     75e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     762:	fc042783          	lw	a5,-64(s0)
     766:	2781                	sext.w	a5,a5
     768:	c38d                	beqz	a5,78a <printint+0x4e>
     76a:	fc842783          	lw	a5,-56(s0)
     76e:	2781                	sext.w	a5,a5
     770:	0007dd63          	bgez	a5,78a <printint+0x4e>
    neg = 1;
     774:	4785                	li	a5,1
     776:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     77a:	fc842783          	lw	a5,-56(s0)
     77e:	40f007bb          	negw	a5,a5
     782:	2781                	sext.w	a5,a5
     784:	fef42223          	sw	a5,-28(s0)
     788:	a029                	j	792 <printint+0x56>
  } else {
    x = xx;
     78a:	fc842783          	lw	a5,-56(s0)
     78e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     792:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     796:	fc442783          	lw	a5,-60(s0)
     79a:	fe442703          	lw	a4,-28(s0)
     79e:	02f777bb          	remuw	a5,a4,a5
     7a2:	0007861b          	sext.w	a2,a5
     7a6:	fec42783          	lw	a5,-20(s0)
     7aa:	0017871b          	addiw	a4,a5,1
     7ae:	fee42623          	sw	a4,-20(s0)
     7b2:	00002697          	auipc	a3,0x2
     7b6:	a5e68693          	addi	a3,a3,-1442 # 2210 <digits>
     7ba:	02061713          	slli	a4,a2,0x20
     7be:	9301                	srli	a4,a4,0x20
     7c0:	9736                	add	a4,a4,a3
     7c2:	00074703          	lbu	a4,0(a4)
     7c6:	ff040693          	addi	a3,s0,-16
     7ca:	97b6                	add	a5,a5,a3
     7cc:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     7d0:	fc442783          	lw	a5,-60(s0)
     7d4:	fe442703          	lw	a4,-28(s0)
     7d8:	02f757bb          	divuw	a5,a4,a5
     7dc:	fef42223          	sw	a5,-28(s0)
     7e0:	fe442783          	lw	a5,-28(s0)
     7e4:	2781                	sext.w	a5,a5
     7e6:	fbc5                	bnez	a5,796 <printint+0x5a>
  if(neg)
     7e8:	fe842783          	lw	a5,-24(s0)
     7ec:	2781                	sext.w	a5,a5
     7ee:	cf95                	beqz	a5,82a <printint+0xee>
    buf[i++] = '-';
     7f0:	fec42783          	lw	a5,-20(s0)
     7f4:	0017871b          	addiw	a4,a5,1
     7f8:	fee42623          	sw	a4,-20(s0)
     7fc:	ff040713          	addi	a4,s0,-16
     800:	97ba                	add	a5,a5,a4
     802:	02d00713          	li	a4,45
     806:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     80a:	a005                	j	82a <printint+0xee>
    putc(fd, buf[i]);
     80c:	fec42783          	lw	a5,-20(s0)
     810:	ff040713          	addi	a4,s0,-16
     814:	97ba                	add	a5,a5,a4
     816:	fe07c703          	lbu	a4,-32(a5)
     81a:	fcc42783          	lw	a5,-52(s0)
     81e:	85ba                	mv	a1,a4
     820:	853e                	mv	a0,a5
     822:	00000097          	auipc	ra,0x0
     826:	ee4080e7          	jalr	-284(ra) # 706 <putc>
  while(--i >= 0)
     82a:	fec42783          	lw	a5,-20(s0)
     82e:	37fd                	addiw	a5,a5,-1
     830:	fef42623          	sw	a5,-20(s0)
     834:	fec42783          	lw	a5,-20(s0)
     838:	2781                	sext.w	a5,a5
     83a:	fc07d9e3          	bgez	a5,80c <printint+0xd0>
}
     83e:	0001                	nop
     840:	0001                	nop
     842:	70e2                	ld	ra,56(sp)
     844:	7442                	ld	s0,48(sp)
     846:	6121                	addi	sp,sp,64
     848:	8082                	ret

000000000000084a <printptr>:

static void
printptr(int fd, uint64 x) {
     84a:	7179                	addi	sp,sp,-48
     84c:	f406                	sd	ra,40(sp)
     84e:	f022                	sd	s0,32(sp)
     850:	1800                	addi	s0,sp,48
     852:	87aa                	mv	a5,a0
     854:	fcb43823          	sd	a1,-48(s0)
     858:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     85c:	fdc42783          	lw	a5,-36(s0)
     860:	03000593          	li	a1,48
     864:	853e                	mv	a0,a5
     866:	00000097          	auipc	ra,0x0
     86a:	ea0080e7          	jalr	-352(ra) # 706 <putc>
  putc(fd, 'x');
     86e:	fdc42783          	lw	a5,-36(s0)
     872:	07800593          	li	a1,120
     876:	853e                	mv	a0,a5
     878:	00000097          	auipc	ra,0x0
     87c:	e8e080e7          	jalr	-370(ra) # 706 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     880:	fe042623          	sw	zero,-20(s0)
     884:	a82d                	j	8be <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     886:	fd043783          	ld	a5,-48(s0)
     88a:	93f1                	srli	a5,a5,0x3c
     88c:	00002717          	auipc	a4,0x2
     890:	98470713          	addi	a4,a4,-1660 # 2210 <digits>
     894:	97ba                	add	a5,a5,a4
     896:	0007c703          	lbu	a4,0(a5)
     89a:	fdc42783          	lw	a5,-36(s0)
     89e:	85ba                	mv	a1,a4
     8a0:	853e                	mv	a0,a5
     8a2:	00000097          	auipc	ra,0x0
     8a6:	e64080e7          	jalr	-412(ra) # 706 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8aa:	fec42783          	lw	a5,-20(s0)
     8ae:	2785                	addiw	a5,a5,1
     8b0:	fef42623          	sw	a5,-20(s0)
     8b4:	fd043783          	ld	a5,-48(s0)
     8b8:	0792                	slli	a5,a5,0x4
     8ba:	fcf43823          	sd	a5,-48(s0)
     8be:	fec42783          	lw	a5,-20(s0)
     8c2:	873e                	mv	a4,a5
     8c4:	47bd                	li	a5,15
     8c6:	fce7f0e3          	bgeu	a5,a4,886 <printptr+0x3c>
}
     8ca:	0001                	nop
     8cc:	0001                	nop
     8ce:	70a2                	ld	ra,40(sp)
     8d0:	7402                	ld	s0,32(sp)
     8d2:	6145                	addi	sp,sp,48
     8d4:	8082                	ret

00000000000008d6 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     8d6:	715d                	addi	sp,sp,-80
     8d8:	e486                	sd	ra,72(sp)
     8da:	e0a2                	sd	s0,64(sp)
     8dc:	0880                	addi	s0,sp,80
     8de:	87aa                	mv	a5,a0
     8e0:	fcb43023          	sd	a1,-64(s0)
     8e4:	fac43c23          	sd	a2,-72(s0)
     8e8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     8ec:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     8f0:	fe042223          	sw	zero,-28(s0)
     8f4:	a42d                	j	b1e <vprintf+0x248>
    c = fmt[i] & 0xff;
     8f6:	fe442783          	lw	a5,-28(s0)
     8fa:	fc043703          	ld	a4,-64(s0)
     8fe:	97ba                	add	a5,a5,a4
     900:	0007c783          	lbu	a5,0(a5)
     904:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     908:	fe042783          	lw	a5,-32(s0)
     90c:	2781                	sext.w	a5,a5
     90e:	eb9d                	bnez	a5,944 <vprintf+0x6e>
      if(c == '%'){
     910:	fdc42783          	lw	a5,-36(s0)
     914:	0007871b          	sext.w	a4,a5
     918:	02500793          	li	a5,37
     91c:	00f71763          	bne	a4,a5,92a <vprintf+0x54>
        state = '%';
     920:	02500793          	li	a5,37
     924:	fef42023          	sw	a5,-32(s0)
     928:	a2f5                	j	b14 <vprintf+0x23e>
      } else {
        putc(fd, c);
     92a:	fdc42783          	lw	a5,-36(s0)
     92e:	0ff7f713          	andi	a4,a5,255
     932:	fcc42783          	lw	a5,-52(s0)
     936:	85ba                	mv	a1,a4
     938:	853e                	mv	a0,a5
     93a:	00000097          	auipc	ra,0x0
     93e:	dcc080e7          	jalr	-564(ra) # 706 <putc>
     942:	aac9                	j	b14 <vprintf+0x23e>
      }
    } else if(state == '%'){
     944:	fe042783          	lw	a5,-32(s0)
     948:	0007871b          	sext.w	a4,a5
     94c:	02500793          	li	a5,37
     950:	1cf71263          	bne	a4,a5,b14 <vprintf+0x23e>
      if(c == 'd'){
     954:	fdc42783          	lw	a5,-36(s0)
     958:	0007871b          	sext.w	a4,a5
     95c:	06400793          	li	a5,100
     960:	02f71463          	bne	a4,a5,988 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     964:	fb843783          	ld	a5,-72(s0)
     968:	00878713          	addi	a4,a5,8
     96c:	fae43c23          	sd	a4,-72(s0)
     970:	4398                	lw	a4,0(a5)
     972:	fcc42783          	lw	a5,-52(s0)
     976:	4685                	li	a3,1
     978:	4629                	li	a2,10
     97a:	85ba                	mv	a1,a4
     97c:	853e                	mv	a0,a5
     97e:	00000097          	auipc	ra,0x0
     982:	dbe080e7          	jalr	-578(ra) # 73c <printint>
     986:	a269                	j	b10 <vprintf+0x23a>
      } else if(c == 'l') {
     988:	fdc42783          	lw	a5,-36(s0)
     98c:	0007871b          	sext.w	a4,a5
     990:	06c00793          	li	a5,108
     994:	02f71663          	bne	a4,a5,9c0 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     998:	fb843783          	ld	a5,-72(s0)
     99c:	00878713          	addi	a4,a5,8
     9a0:	fae43c23          	sd	a4,-72(s0)
     9a4:	639c                	ld	a5,0(a5)
     9a6:	0007871b          	sext.w	a4,a5
     9aa:	fcc42783          	lw	a5,-52(s0)
     9ae:	4681                	li	a3,0
     9b0:	4629                	li	a2,10
     9b2:	85ba                	mv	a1,a4
     9b4:	853e                	mv	a0,a5
     9b6:	00000097          	auipc	ra,0x0
     9ba:	d86080e7          	jalr	-634(ra) # 73c <printint>
     9be:	aa89                	j	b10 <vprintf+0x23a>
      } else if(c == 'x') {
     9c0:	fdc42783          	lw	a5,-36(s0)
     9c4:	0007871b          	sext.w	a4,a5
     9c8:	07800793          	li	a5,120
     9cc:	02f71463          	bne	a4,a5,9f4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     9d0:	fb843783          	ld	a5,-72(s0)
     9d4:	00878713          	addi	a4,a5,8
     9d8:	fae43c23          	sd	a4,-72(s0)
     9dc:	4398                	lw	a4,0(a5)
     9de:	fcc42783          	lw	a5,-52(s0)
     9e2:	4681                	li	a3,0
     9e4:	4641                	li	a2,16
     9e6:	85ba                	mv	a1,a4
     9e8:	853e                	mv	a0,a5
     9ea:	00000097          	auipc	ra,0x0
     9ee:	d52080e7          	jalr	-686(ra) # 73c <printint>
     9f2:	aa39                	j	b10 <vprintf+0x23a>
      } else if(c == 'p') {
     9f4:	fdc42783          	lw	a5,-36(s0)
     9f8:	0007871b          	sext.w	a4,a5
     9fc:	07000793          	li	a5,112
     a00:	02f71263          	bne	a4,a5,a24 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     a04:	fb843783          	ld	a5,-72(s0)
     a08:	00878713          	addi	a4,a5,8
     a0c:	fae43c23          	sd	a4,-72(s0)
     a10:	6398                	ld	a4,0(a5)
     a12:	fcc42783          	lw	a5,-52(s0)
     a16:	85ba                	mv	a1,a4
     a18:	853e                	mv	a0,a5
     a1a:	00000097          	auipc	ra,0x0
     a1e:	e30080e7          	jalr	-464(ra) # 84a <printptr>
     a22:	a0fd                	j	b10 <vprintf+0x23a>
      } else if(c == 's'){
     a24:	fdc42783          	lw	a5,-36(s0)
     a28:	0007871b          	sext.w	a4,a5
     a2c:	07300793          	li	a5,115
     a30:	04f71c63          	bne	a4,a5,a88 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     a34:	fb843783          	ld	a5,-72(s0)
     a38:	00878713          	addi	a4,a5,8
     a3c:	fae43c23          	sd	a4,-72(s0)
     a40:	639c                	ld	a5,0(a5)
     a42:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     a46:	fe843783          	ld	a5,-24(s0)
     a4a:	eb8d                	bnez	a5,a7c <vprintf+0x1a6>
          s = "(null)";
     a4c:	00001797          	auipc	a5,0x1
     a50:	64478793          	addi	a5,a5,1604 # 2090 <schedule_dm+0x320>
     a54:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a58:	a015                	j	a7c <vprintf+0x1a6>
          putc(fd, *s);
     a5a:	fe843783          	ld	a5,-24(s0)
     a5e:	0007c703          	lbu	a4,0(a5)
     a62:	fcc42783          	lw	a5,-52(s0)
     a66:	85ba                	mv	a1,a4
     a68:	853e                	mv	a0,a5
     a6a:	00000097          	auipc	ra,0x0
     a6e:	c9c080e7          	jalr	-868(ra) # 706 <putc>
          s++;
     a72:	fe843783          	ld	a5,-24(s0)
     a76:	0785                	addi	a5,a5,1
     a78:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a7c:	fe843783          	ld	a5,-24(s0)
     a80:	0007c783          	lbu	a5,0(a5)
     a84:	fbf9                	bnez	a5,a5a <vprintf+0x184>
     a86:	a069                	j	b10 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     a88:	fdc42783          	lw	a5,-36(s0)
     a8c:	0007871b          	sext.w	a4,a5
     a90:	06300793          	li	a5,99
     a94:	02f71463          	bne	a4,a5,abc <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     a98:	fb843783          	ld	a5,-72(s0)
     a9c:	00878713          	addi	a4,a5,8
     aa0:	fae43c23          	sd	a4,-72(s0)
     aa4:	439c                	lw	a5,0(a5)
     aa6:	0ff7f713          	andi	a4,a5,255
     aaa:	fcc42783          	lw	a5,-52(s0)
     aae:	85ba                	mv	a1,a4
     ab0:	853e                	mv	a0,a5
     ab2:	00000097          	auipc	ra,0x0
     ab6:	c54080e7          	jalr	-940(ra) # 706 <putc>
     aba:	a899                	j	b10 <vprintf+0x23a>
      } else if(c == '%'){
     abc:	fdc42783          	lw	a5,-36(s0)
     ac0:	0007871b          	sext.w	a4,a5
     ac4:	02500793          	li	a5,37
     ac8:	00f71f63          	bne	a4,a5,ae6 <vprintf+0x210>
        putc(fd, c);
     acc:	fdc42783          	lw	a5,-36(s0)
     ad0:	0ff7f713          	andi	a4,a5,255
     ad4:	fcc42783          	lw	a5,-52(s0)
     ad8:	85ba                	mv	a1,a4
     ada:	853e                	mv	a0,a5
     adc:	00000097          	auipc	ra,0x0
     ae0:	c2a080e7          	jalr	-982(ra) # 706 <putc>
     ae4:	a035                	j	b10 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     ae6:	fcc42783          	lw	a5,-52(s0)
     aea:	02500593          	li	a1,37
     aee:	853e                	mv	a0,a5
     af0:	00000097          	auipc	ra,0x0
     af4:	c16080e7          	jalr	-1002(ra) # 706 <putc>
        putc(fd, c);
     af8:	fdc42783          	lw	a5,-36(s0)
     afc:	0ff7f713          	andi	a4,a5,255
     b00:	fcc42783          	lw	a5,-52(s0)
     b04:	85ba                	mv	a1,a4
     b06:	853e                	mv	a0,a5
     b08:	00000097          	auipc	ra,0x0
     b0c:	bfe080e7          	jalr	-1026(ra) # 706 <putc>
      }
      state = 0;
     b10:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b14:	fe442783          	lw	a5,-28(s0)
     b18:	2785                	addiw	a5,a5,1
     b1a:	fef42223          	sw	a5,-28(s0)
     b1e:	fe442783          	lw	a5,-28(s0)
     b22:	fc043703          	ld	a4,-64(s0)
     b26:	97ba                	add	a5,a5,a4
     b28:	0007c783          	lbu	a5,0(a5)
     b2c:	dc0795e3          	bnez	a5,8f6 <vprintf+0x20>
    }
  }
}
     b30:	0001                	nop
     b32:	0001                	nop
     b34:	60a6                	ld	ra,72(sp)
     b36:	6406                	ld	s0,64(sp)
     b38:	6161                	addi	sp,sp,80
     b3a:	8082                	ret

0000000000000b3c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     b3c:	7159                	addi	sp,sp,-112
     b3e:	fc06                	sd	ra,56(sp)
     b40:	f822                	sd	s0,48(sp)
     b42:	0080                	addi	s0,sp,64
     b44:	fcb43823          	sd	a1,-48(s0)
     b48:	e010                	sd	a2,0(s0)
     b4a:	e414                	sd	a3,8(s0)
     b4c:	e818                	sd	a4,16(s0)
     b4e:	ec1c                	sd	a5,24(s0)
     b50:	03043023          	sd	a6,32(s0)
     b54:	03143423          	sd	a7,40(s0)
     b58:	87aa                	mv	a5,a0
     b5a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     b5e:	03040793          	addi	a5,s0,48
     b62:	fcf43423          	sd	a5,-56(s0)
     b66:	fc843783          	ld	a5,-56(s0)
     b6a:	fd078793          	addi	a5,a5,-48
     b6e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     b72:	fe843703          	ld	a4,-24(s0)
     b76:	fdc42783          	lw	a5,-36(s0)
     b7a:	863a                	mv	a2,a4
     b7c:	fd043583          	ld	a1,-48(s0)
     b80:	853e                	mv	a0,a5
     b82:	00000097          	auipc	ra,0x0
     b86:	d54080e7          	jalr	-684(ra) # 8d6 <vprintf>
}
     b8a:	0001                	nop
     b8c:	70e2                	ld	ra,56(sp)
     b8e:	7442                	ld	s0,48(sp)
     b90:	6165                	addi	sp,sp,112
     b92:	8082                	ret

0000000000000b94 <printf>:

void
printf(const char *fmt, ...)
{
     b94:	7159                	addi	sp,sp,-112
     b96:	f406                	sd	ra,40(sp)
     b98:	f022                	sd	s0,32(sp)
     b9a:	1800                	addi	s0,sp,48
     b9c:	fca43c23          	sd	a0,-40(s0)
     ba0:	e40c                	sd	a1,8(s0)
     ba2:	e810                	sd	a2,16(s0)
     ba4:	ec14                	sd	a3,24(s0)
     ba6:	f018                	sd	a4,32(s0)
     ba8:	f41c                	sd	a5,40(s0)
     baa:	03043823          	sd	a6,48(s0)
     bae:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     bb2:	04040793          	addi	a5,s0,64
     bb6:	fcf43823          	sd	a5,-48(s0)
     bba:	fd043783          	ld	a5,-48(s0)
     bbe:	fc878793          	addi	a5,a5,-56
     bc2:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     bc6:	fe843783          	ld	a5,-24(s0)
     bca:	863e                	mv	a2,a5
     bcc:	fd843583          	ld	a1,-40(s0)
     bd0:	4505                	li	a0,1
     bd2:	00000097          	auipc	ra,0x0
     bd6:	d04080e7          	jalr	-764(ra) # 8d6 <vprintf>
}
     bda:	0001                	nop
     bdc:	70a2                	ld	ra,40(sp)
     bde:	7402                	ld	s0,32(sp)
     be0:	6165                	addi	sp,sp,112
     be2:	8082                	ret

0000000000000be4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     be4:	7179                	addi	sp,sp,-48
     be6:	f422                	sd	s0,40(sp)
     be8:	1800                	addi	s0,sp,48
     bea:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     bee:	fd843783          	ld	a5,-40(s0)
     bf2:	17c1                	addi	a5,a5,-16
     bf4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bf8:	00001797          	auipc	a5,0x1
     bfc:	67078793          	addi	a5,a5,1648 # 2268 <freep>
     c00:	639c                	ld	a5,0(a5)
     c02:	fef43423          	sd	a5,-24(s0)
     c06:	a815                	j	c3a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     c08:	fe843783          	ld	a5,-24(s0)
     c0c:	639c                	ld	a5,0(a5)
     c0e:	fe843703          	ld	a4,-24(s0)
     c12:	00f76f63          	bltu	a4,a5,c30 <free+0x4c>
     c16:	fe043703          	ld	a4,-32(s0)
     c1a:	fe843783          	ld	a5,-24(s0)
     c1e:	02e7eb63          	bltu	a5,a4,c54 <free+0x70>
     c22:	fe843783          	ld	a5,-24(s0)
     c26:	639c                	ld	a5,0(a5)
     c28:	fe043703          	ld	a4,-32(s0)
     c2c:	02f76463          	bltu	a4,a5,c54 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c30:	fe843783          	ld	a5,-24(s0)
     c34:	639c                	ld	a5,0(a5)
     c36:	fef43423          	sd	a5,-24(s0)
     c3a:	fe043703          	ld	a4,-32(s0)
     c3e:	fe843783          	ld	a5,-24(s0)
     c42:	fce7f3e3          	bgeu	a5,a4,c08 <free+0x24>
     c46:	fe843783          	ld	a5,-24(s0)
     c4a:	639c                	ld	a5,0(a5)
     c4c:	fe043703          	ld	a4,-32(s0)
     c50:	faf77ce3          	bgeu	a4,a5,c08 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     c54:	fe043783          	ld	a5,-32(s0)
     c58:	479c                	lw	a5,8(a5)
     c5a:	1782                	slli	a5,a5,0x20
     c5c:	9381                	srli	a5,a5,0x20
     c5e:	0792                	slli	a5,a5,0x4
     c60:	fe043703          	ld	a4,-32(s0)
     c64:	973e                	add	a4,a4,a5
     c66:	fe843783          	ld	a5,-24(s0)
     c6a:	639c                	ld	a5,0(a5)
     c6c:	02f71763          	bne	a4,a5,c9a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     c70:	fe043783          	ld	a5,-32(s0)
     c74:	4798                	lw	a4,8(a5)
     c76:	fe843783          	ld	a5,-24(s0)
     c7a:	639c                	ld	a5,0(a5)
     c7c:	479c                	lw	a5,8(a5)
     c7e:	9fb9                	addw	a5,a5,a4
     c80:	0007871b          	sext.w	a4,a5
     c84:	fe043783          	ld	a5,-32(s0)
     c88:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     c8a:	fe843783          	ld	a5,-24(s0)
     c8e:	639c                	ld	a5,0(a5)
     c90:	6398                	ld	a4,0(a5)
     c92:	fe043783          	ld	a5,-32(s0)
     c96:	e398                	sd	a4,0(a5)
     c98:	a039                	j	ca6 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     c9a:	fe843783          	ld	a5,-24(s0)
     c9e:	6398                	ld	a4,0(a5)
     ca0:	fe043783          	ld	a5,-32(s0)
     ca4:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     ca6:	fe843783          	ld	a5,-24(s0)
     caa:	479c                	lw	a5,8(a5)
     cac:	1782                	slli	a5,a5,0x20
     cae:	9381                	srli	a5,a5,0x20
     cb0:	0792                	slli	a5,a5,0x4
     cb2:	fe843703          	ld	a4,-24(s0)
     cb6:	97ba                	add	a5,a5,a4
     cb8:	fe043703          	ld	a4,-32(s0)
     cbc:	02f71563          	bne	a4,a5,ce6 <free+0x102>
    p->s.size += bp->s.size;
     cc0:	fe843783          	ld	a5,-24(s0)
     cc4:	4798                	lw	a4,8(a5)
     cc6:	fe043783          	ld	a5,-32(s0)
     cca:	479c                	lw	a5,8(a5)
     ccc:	9fb9                	addw	a5,a5,a4
     cce:	0007871b          	sext.w	a4,a5
     cd2:	fe843783          	ld	a5,-24(s0)
     cd6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     cd8:	fe043783          	ld	a5,-32(s0)
     cdc:	6398                	ld	a4,0(a5)
     cde:	fe843783          	ld	a5,-24(s0)
     ce2:	e398                	sd	a4,0(a5)
     ce4:	a031                	j	cf0 <free+0x10c>
  } else
    p->s.ptr = bp;
     ce6:	fe843783          	ld	a5,-24(s0)
     cea:	fe043703          	ld	a4,-32(s0)
     cee:	e398                	sd	a4,0(a5)
  freep = p;
     cf0:	00001797          	auipc	a5,0x1
     cf4:	57878793          	addi	a5,a5,1400 # 2268 <freep>
     cf8:	fe843703          	ld	a4,-24(s0)
     cfc:	e398                	sd	a4,0(a5)
}
     cfe:	0001                	nop
     d00:	7422                	ld	s0,40(sp)
     d02:	6145                	addi	sp,sp,48
     d04:	8082                	ret

0000000000000d06 <morecore>:

static Header*
morecore(uint nu)
{
     d06:	7179                	addi	sp,sp,-48
     d08:	f406                	sd	ra,40(sp)
     d0a:	f022                	sd	s0,32(sp)
     d0c:	1800                	addi	s0,sp,48
     d0e:	87aa                	mv	a5,a0
     d10:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     d14:	fdc42783          	lw	a5,-36(s0)
     d18:	0007871b          	sext.w	a4,a5
     d1c:	6785                	lui	a5,0x1
     d1e:	00f77563          	bgeu	a4,a5,d28 <morecore+0x22>
    nu = 4096;
     d22:	6785                	lui	a5,0x1
     d24:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     d28:	fdc42783          	lw	a5,-36(s0)
     d2c:	0047979b          	slliw	a5,a5,0x4
     d30:	2781                	sext.w	a5,a5
     d32:	2781                	sext.w	a5,a5
     d34:	853e                	mv	a0,a5
     d36:	00000097          	auipc	ra,0x0
     d3a:	9a0080e7          	jalr	-1632(ra) # 6d6 <sbrk>
     d3e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     d42:	fe843703          	ld	a4,-24(s0)
     d46:	57fd                	li	a5,-1
     d48:	00f71463          	bne	a4,a5,d50 <morecore+0x4a>
    return 0;
     d4c:	4781                	li	a5,0
     d4e:	a03d                	j	d7c <morecore+0x76>
  hp = (Header*)p;
     d50:	fe843783          	ld	a5,-24(s0)
     d54:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     d58:	fe043783          	ld	a5,-32(s0)
     d5c:	fdc42703          	lw	a4,-36(s0)
     d60:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     d62:	fe043783          	ld	a5,-32(s0)
     d66:	07c1                	addi	a5,a5,16
     d68:	853e                	mv	a0,a5
     d6a:	00000097          	auipc	ra,0x0
     d6e:	e7a080e7          	jalr	-390(ra) # be4 <free>
  return freep;
     d72:	00001797          	auipc	a5,0x1
     d76:	4f678793          	addi	a5,a5,1270 # 2268 <freep>
     d7a:	639c                	ld	a5,0(a5)
}
     d7c:	853e                	mv	a0,a5
     d7e:	70a2                	ld	ra,40(sp)
     d80:	7402                	ld	s0,32(sp)
     d82:	6145                	addi	sp,sp,48
     d84:	8082                	ret

0000000000000d86 <malloc>:

void*
malloc(uint nbytes)
{
     d86:	7139                	addi	sp,sp,-64
     d88:	fc06                	sd	ra,56(sp)
     d8a:	f822                	sd	s0,48(sp)
     d8c:	0080                	addi	s0,sp,64
     d8e:	87aa                	mv	a5,a0
     d90:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     d94:	fcc46783          	lwu	a5,-52(s0)
     d98:	07bd                	addi	a5,a5,15
     d9a:	8391                	srli	a5,a5,0x4
     d9c:	2781                	sext.w	a5,a5
     d9e:	2785                	addiw	a5,a5,1
     da0:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     da4:	00001797          	auipc	a5,0x1
     da8:	4c478793          	addi	a5,a5,1220 # 2268 <freep>
     dac:	639c                	ld	a5,0(a5)
     dae:	fef43023          	sd	a5,-32(s0)
     db2:	fe043783          	ld	a5,-32(s0)
     db6:	ef95                	bnez	a5,df2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     db8:	00001797          	auipc	a5,0x1
     dbc:	4a078793          	addi	a5,a5,1184 # 2258 <base>
     dc0:	fef43023          	sd	a5,-32(s0)
     dc4:	00001797          	auipc	a5,0x1
     dc8:	4a478793          	addi	a5,a5,1188 # 2268 <freep>
     dcc:	fe043703          	ld	a4,-32(s0)
     dd0:	e398                	sd	a4,0(a5)
     dd2:	00001797          	auipc	a5,0x1
     dd6:	49678793          	addi	a5,a5,1174 # 2268 <freep>
     dda:	6398                	ld	a4,0(a5)
     ddc:	00001797          	auipc	a5,0x1
     de0:	47c78793          	addi	a5,a5,1148 # 2258 <base>
     de4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     de6:	00001797          	auipc	a5,0x1
     dea:	47278793          	addi	a5,a5,1138 # 2258 <base>
     dee:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     df2:	fe043783          	ld	a5,-32(s0)
     df6:	639c                	ld	a5,0(a5)
     df8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     dfc:	fe843783          	ld	a5,-24(s0)
     e00:	4798                	lw	a4,8(a5)
     e02:	fdc42783          	lw	a5,-36(s0)
     e06:	2781                	sext.w	a5,a5
     e08:	06f76863          	bltu	a4,a5,e78 <malloc+0xf2>
      if(p->s.size == nunits)
     e0c:	fe843783          	ld	a5,-24(s0)
     e10:	4798                	lw	a4,8(a5)
     e12:	fdc42783          	lw	a5,-36(s0)
     e16:	2781                	sext.w	a5,a5
     e18:	00e79963          	bne	a5,a4,e2a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     e1c:	fe843783          	ld	a5,-24(s0)
     e20:	6398                	ld	a4,0(a5)
     e22:	fe043783          	ld	a5,-32(s0)
     e26:	e398                	sd	a4,0(a5)
     e28:	a82d                	j	e62 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     e2a:	fe843783          	ld	a5,-24(s0)
     e2e:	4798                	lw	a4,8(a5)
     e30:	fdc42783          	lw	a5,-36(s0)
     e34:	40f707bb          	subw	a5,a4,a5
     e38:	0007871b          	sext.w	a4,a5
     e3c:	fe843783          	ld	a5,-24(s0)
     e40:	c798                	sw	a4,8(a5)
        p += p->s.size;
     e42:	fe843783          	ld	a5,-24(s0)
     e46:	479c                	lw	a5,8(a5)
     e48:	1782                	slli	a5,a5,0x20
     e4a:	9381                	srli	a5,a5,0x20
     e4c:	0792                	slli	a5,a5,0x4
     e4e:	fe843703          	ld	a4,-24(s0)
     e52:	97ba                	add	a5,a5,a4
     e54:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     e58:	fe843783          	ld	a5,-24(s0)
     e5c:	fdc42703          	lw	a4,-36(s0)
     e60:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     e62:	00001797          	auipc	a5,0x1
     e66:	40678793          	addi	a5,a5,1030 # 2268 <freep>
     e6a:	fe043703          	ld	a4,-32(s0)
     e6e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     e70:	fe843783          	ld	a5,-24(s0)
     e74:	07c1                	addi	a5,a5,16
     e76:	a091                	j	eba <malloc+0x134>
    }
    if(p == freep)
     e78:	00001797          	auipc	a5,0x1
     e7c:	3f078793          	addi	a5,a5,1008 # 2268 <freep>
     e80:	639c                	ld	a5,0(a5)
     e82:	fe843703          	ld	a4,-24(s0)
     e86:	02f71063          	bne	a4,a5,ea6 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     e8a:	fdc42783          	lw	a5,-36(s0)
     e8e:	853e                	mv	a0,a5
     e90:	00000097          	auipc	ra,0x0
     e94:	e76080e7          	jalr	-394(ra) # d06 <morecore>
     e98:	fea43423          	sd	a0,-24(s0)
     e9c:	fe843783          	ld	a5,-24(s0)
     ea0:	e399                	bnez	a5,ea6 <malloc+0x120>
        return 0;
     ea2:	4781                	li	a5,0
     ea4:	a819                	j	eba <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ea6:	fe843783          	ld	a5,-24(s0)
     eaa:	fef43023          	sd	a5,-32(s0)
     eae:	fe843783          	ld	a5,-24(s0)
     eb2:	639c                	ld	a5,0(a5)
     eb4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     eb8:	b791                	j	dfc <malloc+0x76>
  }
}
     eba:	853e                	mv	a0,a5
     ebc:	70e2                	ld	ra,56(sp)
     ebe:	7442                	ld	s0,48(sp)
     ec0:	6121                	addi	sp,sp,64
     ec2:	8082                	ret

0000000000000ec4 <setjmp>:
     ec4:	e100                	sd	s0,0(a0)
     ec6:	e504                	sd	s1,8(a0)
     ec8:	01253823          	sd	s2,16(a0)
     ecc:	01353c23          	sd	s3,24(a0)
     ed0:	03453023          	sd	s4,32(a0)
     ed4:	03553423          	sd	s5,40(a0)
     ed8:	03653823          	sd	s6,48(a0)
     edc:	03753c23          	sd	s7,56(a0)
     ee0:	05853023          	sd	s8,64(a0)
     ee4:	05953423          	sd	s9,72(a0)
     ee8:	05a53823          	sd	s10,80(a0)
     eec:	05b53c23          	sd	s11,88(a0)
     ef0:	06153023          	sd	ra,96(a0)
     ef4:	06253423          	sd	sp,104(a0)
     ef8:	4501                	li	a0,0
     efa:	8082                	ret

0000000000000efc <longjmp>:
     efc:	6100                	ld	s0,0(a0)
     efe:	6504                	ld	s1,8(a0)
     f00:	01053903          	ld	s2,16(a0)
     f04:	01853983          	ld	s3,24(a0)
     f08:	02053a03          	ld	s4,32(a0)
     f0c:	02853a83          	ld	s5,40(a0)
     f10:	03053b03          	ld	s6,48(a0)
     f14:	03853b83          	ld	s7,56(a0)
     f18:	04053c03          	ld	s8,64(a0)
     f1c:	04853c83          	ld	s9,72(a0)
     f20:	05053d03          	ld	s10,80(a0)
     f24:	05853d83          	ld	s11,88(a0)
     f28:	06053083          	ld	ra,96(a0)
     f2c:	06853103          	ld	sp,104(a0)
     f30:	c199                	beqz	a1,f36 <longjmp_1>
     f32:	852e                	mv	a0,a1
     f34:	8082                	ret

0000000000000f36 <longjmp_1>:
     f36:	4505                	li	a0,1
     f38:	8082                	ret

0000000000000f3a <__list_add>:
 * the prev/next entries already!
 */
static inline void __list_add(struct list_head *new_entry,
                              struct list_head *prev,
                              struct list_head *next)
{
     f3a:	7179                	addi	sp,sp,-48
     f3c:	f422                	sd	s0,40(sp)
     f3e:	1800                	addi	s0,sp,48
     f40:	fea43423          	sd	a0,-24(s0)
     f44:	feb43023          	sd	a1,-32(s0)
     f48:	fcc43c23          	sd	a2,-40(s0)
    next->prev = new_entry;
     f4c:	fd843783          	ld	a5,-40(s0)
     f50:	fe843703          	ld	a4,-24(s0)
     f54:	e798                	sd	a4,8(a5)
    new_entry->next = next;
     f56:	fe843783          	ld	a5,-24(s0)
     f5a:	fd843703          	ld	a4,-40(s0)
     f5e:	e398                	sd	a4,0(a5)
    new_entry->prev = prev;
     f60:	fe843783          	ld	a5,-24(s0)
     f64:	fe043703          	ld	a4,-32(s0)
     f68:	e798                	sd	a4,8(a5)
    prev->next = new_entry;
     f6a:	fe043783          	ld	a5,-32(s0)
     f6e:	fe843703          	ld	a4,-24(s0)
     f72:	e398                	sd	a4,0(a5)
}
     f74:	0001                	nop
     f76:	7422                	ld	s0,40(sp)
     f78:	6145                	addi	sp,sp,48
     f7a:	8082                	ret

0000000000000f7c <list_add_tail>:
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static inline void list_add_tail(struct list_head *new_entry, struct list_head *head)
{
     f7c:	1101                	addi	sp,sp,-32
     f7e:	ec06                	sd	ra,24(sp)
     f80:	e822                	sd	s0,16(sp)
     f82:	1000                	addi	s0,sp,32
     f84:	fea43423          	sd	a0,-24(s0)
     f88:	feb43023          	sd	a1,-32(s0)
    __list_add(new_entry, head->prev, head);
     f8c:	fe043783          	ld	a5,-32(s0)
     f90:	679c                	ld	a5,8(a5)
     f92:	fe043603          	ld	a2,-32(s0)
     f96:	85be                	mv	a1,a5
     f98:	fe843503          	ld	a0,-24(s0)
     f9c:	00000097          	auipc	ra,0x0
     fa0:	f9e080e7          	jalr	-98(ra) # f3a <__list_add>
}
     fa4:	0001                	nop
     fa6:	60e2                	ld	ra,24(sp)
     fa8:	6442                	ld	s0,16(sp)
     faa:	6105                	addi	sp,sp,32
     fac:	8082                	ret

0000000000000fae <__list_del>:
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_del(struct list_head *prev, struct list_head *next)
{
     fae:	1101                	addi	sp,sp,-32
     fb0:	ec22                	sd	s0,24(sp)
     fb2:	1000                	addi	s0,sp,32
     fb4:	fea43423          	sd	a0,-24(s0)
     fb8:	feb43023          	sd	a1,-32(s0)
    next->prev = prev;
     fbc:	fe043783          	ld	a5,-32(s0)
     fc0:	fe843703          	ld	a4,-24(s0)
     fc4:	e798                	sd	a4,8(a5)
    prev->next = next;
     fc6:	fe843783          	ld	a5,-24(s0)
     fca:	fe043703          	ld	a4,-32(s0)
     fce:	e398                	sd	a4,0(a5)
}
     fd0:	0001                	nop
     fd2:	6462                	ld	s0,24(sp)
     fd4:	6105                	addi	sp,sp,32
     fd6:	8082                	ret

0000000000000fd8 <list_del>:
 * @entry: the element to delete from the list.
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
 */
static inline void list_del(struct list_head *entry)
{
     fd8:	1101                	addi	sp,sp,-32
     fda:	ec06                	sd	ra,24(sp)
     fdc:	e822                	sd	s0,16(sp)
     fde:	1000                	addi	s0,sp,32
     fe0:	fea43423          	sd	a0,-24(s0)
    __list_del(entry->prev, entry->next);
     fe4:	fe843783          	ld	a5,-24(s0)
     fe8:	6798                	ld	a4,8(a5)
     fea:	fe843783          	ld	a5,-24(s0)
     fee:	639c                	ld	a5,0(a5)
     ff0:	85be                	mv	a1,a5
     ff2:	853a                	mv	a0,a4
     ff4:	00000097          	auipc	ra,0x0
     ff8:	fba080e7          	jalr	-70(ra) # fae <__list_del>
    entry->next = LIST_POISON1;
     ffc:	fe843783          	ld	a5,-24(s0)
    1000:	00100737          	lui	a4,0x100
    1004:	10070713          	addi	a4,a4,256 # 100100 <__global_pointer$+0xfd6f0>
    1008:	e398                	sd	a4,0(a5)
    entry->prev = LIST_POISON2;
    100a:	fe843783          	ld	a5,-24(s0)
    100e:	00200737          	lui	a4,0x200
    1012:	20070713          	addi	a4,a4,512 # 200200 <__global_pointer$+0x1fd7f0>
    1016:	e798                	sd	a4,8(a5)
}
    1018:	0001                	nop
    101a:	60e2                	ld	ra,24(sp)
    101c:	6442                	ld	s0,16(sp)
    101e:	6105                	addi	sp,sp,32
    1020:	8082                	ret

0000000000001022 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
    1022:	1101                	addi	sp,sp,-32
    1024:	ec22                	sd	s0,24(sp)
    1026:	1000                	addi	s0,sp,32
    1028:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
    102c:	fe843783          	ld	a5,-24(s0)
    1030:	639c                	ld	a5,0(a5)
    1032:	fe843703          	ld	a4,-24(s0)
    1036:	40f707b3          	sub	a5,a4,a5
    103a:	0017b793          	seqz	a5,a5
    103e:	0ff7f793          	andi	a5,a5,255
    1042:	2781                	sext.w	a5,a5
}
    1044:	853e                	mv	a0,a5
    1046:	6462                	ld	s0,24(sp)
    1048:	6105                	addi	sp,sp,32
    104a:	8082                	ret

000000000000104c <thread_create>:

void __dispatch(void);
void __schedule(void);

struct thread *thread_create(void (*f)(void *), void *arg, int is_real_time, int processing_time, int period, int n)
{
    104c:	715d                	addi	sp,sp,-80
    104e:	e486                	sd	ra,72(sp)
    1050:	e0a2                	sd	s0,64(sp)
    1052:	0880                	addi	s0,sp,80
    1054:	fca43423          	sd	a0,-56(s0)
    1058:	fcb43023          	sd	a1,-64(s0)
    105c:	85b2                	mv	a1,a2
    105e:	8636                	mv	a2,a3
    1060:	86ba                	mv	a3,a4
    1062:	873e                	mv	a4,a5
    1064:	87ae                	mv	a5,a1
    1066:	faf42e23          	sw	a5,-68(s0)
    106a:	87b2                	mv	a5,a2
    106c:	faf42c23          	sw	a5,-72(s0)
    1070:	87b6                	mv	a5,a3
    1072:	faf42a23          	sw	a5,-76(s0)
    1076:	87ba                	mv	a5,a4
    1078:	faf42823          	sw	a5,-80(s0)
    static int _id = 1;
    struct thread *t = (struct thread *)malloc(sizeof(struct thread));
    107c:	08000513          	li	a0,128
    1080:	00000097          	auipc	ra,0x0
    1084:	d06080e7          	jalr	-762(ra) # d86 <malloc>
    1088:	fea43423          	sd	a0,-24(s0)
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x200);
    108c:	6505                	lui	a0,0x1
    108e:	00000097          	auipc	ra,0x0
    1092:	cf8080e7          	jalr	-776(ra) # d86 <malloc>
    1096:	87aa                	mv	a5,a0
    1098:	fef43023          	sd	a5,-32(s0)
    new_stack_p = new_stack + 0x200 * 8 - 0x2 * 8;
    109c:	fe043703          	ld	a4,-32(s0)
    10a0:	6785                	lui	a5,0x1
    10a2:	17c1                	addi	a5,a5,-16
    10a4:	97ba                	add	a5,a5,a4
    10a6:	fcf43c23          	sd	a5,-40(s0)
    t->fp = f;
    10aa:	fe843783          	ld	a5,-24(s0)
    10ae:	fc843703          	ld	a4,-56(s0)
    10b2:	e398                	sd	a4,0(a5)
    t->arg = arg;
    10b4:	fe843783          	ld	a5,-24(s0)
    10b8:	fc043703          	ld	a4,-64(s0)
    10bc:	e798                	sd	a4,8(a5)
    t->ID = _id++;
    10be:	00001797          	auipc	a5,0x1
    10c2:	18e78793          	addi	a5,a5,398 # 224c <_id.1239>
    10c6:	439c                	lw	a5,0(a5)
    10c8:	0017871b          	addiw	a4,a5,1
    10cc:	0007069b          	sext.w	a3,a4
    10d0:	00001717          	auipc	a4,0x1
    10d4:	17c70713          	addi	a4,a4,380 # 224c <_id.1239>
    10d8:	c314                	sw	a3,0(a4)
    10da:	fe843703          	ld	a4,-24(s0)
    10de:	df5c                	sw	a5,60(a4)
    t->buf_set = 0;
    10e0:	fe843783          	ld	a5,-24(s0)
    10e4:	0207a023          	sw	zero,32(a5)
    t->stack = (void *)new_stack;
    10e8:	fe043703          	ld	a4,-32(s0)
    10ec:	fe843783          	ld	a5,-24(s0)
    10f0:	eb98                	sd	a4,16(a5)
    t->stack_p = (void *)new_stack_p;
    10f2:	fd843703          	ld	a4,-40(s0)
    10f6:	fe843783          	ld	a5,-24(s0)
    10fa:	ef98                	sd	a4,24(a5)

    t->processing_time = processing_time;
    10fc:	fe843783          	ld	a5,-24(s0)
    1100:	fb842703          	lw	a4,-72(s0)
    1104:	c3f8                	sw	a4,68(a5)
    t->period = period;
    1106:	fe843783          	ld	a5,-24(s0)
    110a:	fb442703          	lw	a4,-76(s0)
    110e:	c7f8                	sw	a4,76(a5)
    t->deadline = period;
    1110:	fe843783          	ld	a5,-24(s0)
    1114:	fb442703          	lw	a4,-76(s0)
    1118:	c7b8                	sw	a4,72(a5)
    t->n = n;
    111a:	fe843783          	ld	a5,-24(s0)
    111e:	fb042703          	lw	a4,-80(s0)
    1122:	cbb8                	sw	a4,80(a5)
    t->is_real_time = is_real_time;
    1124:	fe843783          	ld	a5,-24(s0)
    1128:	fbc42703          	lw	a4,-68(s0)
    112c:	c3b8                	sw	a4,64(a5)
    t->remaining_time = processing_time;
    112e:	fe843783          	ld	a5,-24(s0)
    1132:	fb842703          	lw	a4,-72(s0)
    1136:	cbf8                	sw	a4,84(a5)
    t->current_deadline = 0;
    1138:	fe843783          	ld	a5,-24(s0)
    113c:	0407ac23          	sw	zero,88(a5)
    t->priority = 100;
    1140:	fe843783          	ld	a5,-24(s0)
    1144:	06400713          	li	a4,100
    1148:	cff8                	sw	a4,92(a5)
    t->arrival_time = 30000;
    114a:	fe843783          	ld	a5,-24(s0)
    114e:	671d                	lui	a4,0x7
    1150:	5307071b          	addiw	a4,a4,1328
    1154:	d3b8                	sw	a4,96(a5)
    
    return t;
    1156:	fe843783          	ld	a5,-24(s0)
}
    115a:	853e                	mv	a0,a5
    115c:	60a6                	ld	ra,72(sp)
    115e:	6406                	ld	s0,64(sp)
    1160:	6161                	addi	sp,sp,80
    1162:	8082                	ret

0000000000001164 <thread_set_priority>:

void thread_set_priority(struct thread *t, int priority)
{
    1164:	1101                	addi	sp,sp,-32
    1166:	ec22                	sd	s0,24(sp)
    1168:	1000                	addi	s0,sp,32
    116a:	fea43423          	sd	a0,-24(s0)
    116e:	87ae                	mv	a5,a1
    1170:	fef42223          	sw	a5,-28(s0)
    t->priority = priority;
    1174:	fe843783          	ld	a5,-24(s0)
    1178:	fe442703          	lw	a4,-28(s0)
    117c:	cff8                	sw	a4,92(a5)
}
    117e:	0001                	nop
    1180:	6462                	ld	s0,24(sp)
    1182:	6105                	addi	sp,sp,32
    1184:	8082                	ret

0000000000001186 <init_thread_cbs>:
void init_thread_cbs(struct thread *t, int budget, int is_hard_rt)
{
    1186:	1101                	addi	sp,sp,-32
    1188:	ec22                	sd	s0,24(sp)
    118a:	1000                	addi	s0,sp,32
    118c:	fea43423          	sd	a0,-24(s0)
    1190:	87ae                	mv	a5,a1
    1192:	8732                	mv	a4,a2
    1194:	fef42223          	sw	a5,-28(s0)
    1198:	87ba                	mv	a5,a4
    119a:	fef42023          	sw	a5,-32(s0)
    t->cbs.budget = budget;
    119e:	fe843783          	ld	a5,-24(s0)
    11a2:	fe442703          	lw	a4,-28(s0)
    11a6:	d3f8                	sw	a4,100(a5)
    t->cbs.remaining_budget = budget; 
    11a8:	fe843783          	ld	a5,-24(s0)
    11ac:	fe442703          	lw	a4,-28(s0)
    11b0:	d7b8                	sw	a4,104(a5)
    t->cbs.is_hard_rt = is_hard_rt;
    11b2:	fe843783          	ld	a5,-24(s0)
    11b6:	fe042703          	lw	a4,-32(s0)
    11ba:	d7f8                	sw	a4,108(a5)
    t->cbs.is_throttled = 0;
    11bc:	fe843783          	ld	a5,-24(s0)
    11c0:	0607a823          	sw	zero,112(a5)
    t->cbs.throttled_arrived_time = 0;
    11c4:	fe843783          	ld	a5,-24(s0)
    11c8:	0607aa23          	sw	zero,116(a5)
    t->cbs.throttle_new_deadline = 0;
    11cc:	fe843783          	ld	a5,-24(s0)
    11d0:	0607ac23          	sw	zero,120(a5)
}
    11d4:	0001                	nop
    11d6:	6462                	ld	s0,24(sp)
    11d8:	6105                	addi	sp,sp,32
    11da:	8082                	ret

00000000000011dc <thread_add_at>:
void thread_add_at(struct thread *t, int arrival_time)
{
    11dc:	7179                	addi	sp,sp,-48
    11de:	f406                	sd	ra,40(sp)
    11e0:	f022                	sd	s0,32(sp)
    11e2:	1800                	addi	s0,sp,48
    11e4:	fca43c23          	sd	a0,-40(s0)
    11e8:	87ae                	mv	a5,a1
    11ea:	fcf42a23          	sw	a5,-44(s0)
    struct release_queue_entry *new_entry = (struct release_queue_entry *)malloc(sizeof(struct release_queue_entry));
    11ee:	02000513          	li	a0,32
    11f2:	00000097          	auipc	ra,0x0
    11f6:	b94080e7          	jalr	-1132(ra) # d86 <malloc>
    11fa:	fea43423          	sd	a0,-24(s0)
    new_entry->thrd = t;
    11fe:	fe843783          	ld	a5,-24(s0)
    1202:	fd843703          	ld	a4,-40(s0)
    1206:	e398                	sd	a4,0(a5)
    new_entry->release_time = arrival_time;
    1208:	fe843783          	ld	a5,-24(s0)
    120c:	fd442703          	lw	a4,-44(s0)
    1210:	cf98                	sw	a4,24(a5)
    t->arrival_time = arrival_time;
    1212:	fd843783          	ld	a5,-40(s0)
    1216:	fd442703          	lw	a4,-44(s0)
    121a:	d3b8                	sw	a4,96(a5)
    // t->remaining_time = t->processing_time;
    if (t->is_real_time) {
    121c:	fd843783          	ld	a5,-40(s0)
    1220:	43bc                	lw	a5,64(a5)
    1222:	cf81                	beqz	a5,123a <thread_add_at+0x5e>
        t->current_deadline = arrival_time + t->deadline;
    1224:	fd843783          	ld	a5,-40(s0)
    1228:	47bc                	lw	a5,72(a5)
    122a:	fd442703          	lw	a4,-44(s0)
    122e:	9fb9                	addw	a5,a5,a4
    1230:	0007871b          	sext.w	a4,a5
    1234:	fd843783          	ld	a5,-40(s0)
    1238:	cfb8                	sw	a4,88(a5)
    }
    list_add_tail(&new_entry->thread_list, &release_queue);
    123a:	fe843783          	ld	a5,-24(s0)
    123e:	07a1                	addi	a5,a5,8
    1240:	00001597          	auipc	a1,0x1
    1244:	ff858593          	addi	a1,a1,-8 # 2238 <release_queue>
    1248:	853e                	mv	a0,a5
    124a:	00000097          	auipc	ra,0x0
    124e:	d32080e7          	jalr	-718(ra) # f7c <list_add_tail>
}
    1252:	0001                	nop
    1254:	70a2                	ld	ra,40(sp)
    1256:	7402                	ld	s0,32(sp)
    1258:	6145                	addi	sp,sp,48
    125a:	8082                	ret

000000000000125c <__release>:

void __release()
{
    125c:	7139                	addi	sp,sp,-64
    125e:	fc06                	sd	ra,56(sp)
    1260:	f822                	sd	s0,48(sp)
    1262:	0080                	addi	s0,sp,64
    struct release_queue_entry *cur, *nxt;
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    1264:	00001797          	auipc	a5,0x1
    1268:	fd478793          	addi	a5,a5,-44 # 2238 <release_queue>
    126c:	639c                	ld	a5,0(a5)
    126e:	fcf43c23          	sd	a5,-40(s0)
    1272:	fd843783          	ld	a5,-40(s0)
    1276:	17e1                	addi	a5,a5,-8
    1278:	fef43423          	sd	a5,-24(s0)
    127c:	fe843783          	ld	a5,-24(s0)
    1280:	679c                	ld	a5,8(a5)
    1282:	fcf43823          	sd	a5,-48(s0)
    1286:	fd043783          	ld	a5,-48(s0)
    128a:	17e1                	addi	a5,a5,-8
    128c:	fef43023          	sd	a5,-32(s0)
    1290:	a851                	j	1324 <__release+0xc8>
        if (threading_system_time >= cur->release_time) {
    1292:	fe843783          	ld	a5,-24(s0)
    1296:	4f98                	lw	a4,24(a5)
    1298:	00001797          	auipc	a5,0x1
    129c:	fe078793          	addi	a5,a5,-32 # 2278 <threading_system_time>
    12a0:	439c                	lw	a5,0(a5)
    12a2:	06e7c363          	blt	a5,a4,1308 <__release+0xac>
            cur->thrd->remaining_time = cur->thrd->processing_time;
    12a6:	fe843783          	ld	a5,-24(s0)
    12aa:	6398                	ld	a4,0(a5)
    12ac:	fe843783          	ld	a5,-24(s0)
    12b0:	639c                	ld	a5,0(a5)
    12b2:	4378                	lw	a4,68(a4)
    12b4:	cbf8                	sw	a4,84(a5)
            cur->thrd->current_deadline = cur->release_time + cur->thrd->deadline;
    12b6:	fe843783          	ld	a5,-24(s0)
    12ba:	4f94                	lw	a3,24(a5)
    12bc:	fe843783          	ld	a5,-24(s0)
    12c0:	639c                	ld	a5,0(a5)
    12c2:	47b8                	lw	a4,72(a5)
    12c4:	fe843783          	ld	a5,-24(s0)
    12c8:	639c                	ld	a5,0(a5)
    12ca:	9f35                	addw	a4,a4,a3
    12cc:	2701                	sext.w	a4,a4
    12ce:	cfb8                	sw	a4,88(a5)
            list_add_tail(&cur->thrd->thread_list, &run_queue);
    12d0:	fe843783          	ld	a5,-24(s0)
    12d4:	639c                	ld	a5,0(a5)
    12d6:	02878793          	addi	a5,a5,40
    12da:	00001597          	auipc	a1,0x1
    12de:	f4e58593          	addi	a1,a1,-178 # 2228 <run_queue>
    12e2:	853e                	mv	a0,a5
    12e4:	00000097          	auipc	ra,0x0
    12e8:	c98080e7          	jalr	-872(ra) # f7c <list_add_tail>
            list_del(&cur->thread_list);
    12ec:	fe843783          	ld	a5,-24(s0)
    12f0:	07a1                	addi	a5,a5,8
    12f2:	853e                	mv	a0,a5
    12f4:	00000097          	auipc	ra,0x0
    12f8:	ce4080e7          	jalr	-796(ra) # fd8 <list_del>
            free(cur);
    12fc:	fe843503          	ld	a0,-24(s0)
    1300:	00000097          	auipc	ra,0x0
    1304:	8e4080e7          	jalr	-1820(ra) # be4 <free>
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    1308:	fe043783          	ld	a5,-32(s0)
    130c:	fef43423          	sd	a5,-24(s0)
    1310:	fe043783          	ld	a5,-32(s0)
    1314:	679c                	ld	a5,8(a5)
    1316:	fcf43423          	sd	a5,-56(s0)
    131a:	fc843783          	ld	a5,-56(s0)
    131e:	17e1                	addi	a5,a5,-8
    1320:	fef43023          	sd	a5,-32(s0)
    1324:	fe843783          	ld	a5,-24(s0)
    1328:	00878713          	addi	a4,a5,8
    132c:	00001797          	auipc	a5,0x1
    1330:	f0c78793          	addi	a5,a5,-244 # 2238 <release_queue>
    1334:	f4f71fe3          	bne	a4,a5,1292 <__release+0x36>
        }
    }
}
    1338:	0001                	nop
    133a:	0001                	nop
    133c:	70e2                	ld	ra,56(sp)
    133e:	7442                	ld	s0,48(sp)
    1340:	6121                	addi	sp,sp,64
    1342:	8082                	ret

0000000000001344 <__thread_exit>:

void __thread_exit(struct thread *to_remove)
{
    1344:	1101                	addi	sp,sp,-32
    1346:	ec06                	sd	ra,24(sp)
    1348:	e822                	sd	s0,16(sp)
    134a:	1000                	addi	s0,sp,32
    134c:	fea43423          	sd	a0,-24(s0)
    current = to_remove->thread_list.prev;
    1350:	fe843783          	ld	a5,-24(s0)
    1354:	7b98                	ld	a4,48(a5)
    1356:	00001797          	auipc	a5,0x1
    135a:	f1a78793          	addi	a5,a5,-230 # 2270 <current>
    135e:	e398                	sd	a4,0(a5)
    list_del(&to_remove->thread_list);
    1360:	fe843783          	ld	a5,-24(s0)
    1364:	02878793          	addi	a5,a5,40
    1368:	853e                	mv	a0,a5
    136a:	00000097          	auipc	ra,0x0
    136e:	c6e080e7          	jalr	-914(ra) # fd8 <list_del>

    free(to_remove->stack);
    1372:	fe843783          	ld	a5,-24(s0)
    1376:	6b9c                	ld	a5,16(a5)
    1378:	853e                	mv	a0,a5
    137a:	00000097          	auipc	ra,0x0
    137e:	86a080e7          	jalr	-1942(ra) # be4 <free>
    free(to_remove);
    1382:	fe843503          	ld	a0,-24(s0)
    1386:	00000097          	auipc	ra,0x0
    138a:	85e080e7          	jalr	-1954(ra) # be4 <free>

    __schedule();
    138e:	00000097          	auipc	ra,0x0
    1392:	5ae080e7          	jalr	1454(ra) # 193c <__schedule>
    __dispatch();
    1396:	00000097          	auipc	ra,0x0
    139a:	416080e7          	jalr	1046(ra) # 17ac <__dispatch>
    thrdresume(main_thrd_id);
    139e:	00001797          	auipc	a5,0x1
    13a2:	eaa78793          	addi	a5,a5,-342 # 2248 <main_thrd_id>
    13a6:	439c                	lw	a5,0(a5)
    13a8:	853e                	mv	a0,a5
    13aa:	fffff097          	auipc	ra,0xfffff
    13ae:	34c080e7          	jalr	844(ra) # 6f6 <thrdresume>
}
    13b2:	0001                	nop
    13b4:	60e2                	ld	ra,24(sp)
    13b6:	6442                	ld	s0,16(sp)
    13b8:	6105                	addi	sp,sp,32
    13ba:	8082                	ret

00000000000013bc <thread_exit>:

void thread_exit(void)
{
    13bc:	7179                	addi	sp,sp,-48
    13be:	f406                	sd	ra,40(sp)
    13c0:	f022                	sd	s0,32(sp)
    13c2:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    13c4:	00001797          	auipc	a5,0x1
    13c8:	eac78793          	addi	a5,a5,-340 # 2270 <current>
    13cc:	6398                	ld	a4,0(a5)
    13ce:	00001797          	auipc	a5,0x1
    13d2:	e5a78793          	addi	a5,a5,-422 # 2228 <run_queue>
    13d6:	02f71063          	bne	a4,a5,13f6 <thread_exit+0x3a>
        fprintf(2, "[FATAL] thread_exit is called on a nonexistent thread\n");
    13da:	00001597          	auipc	a1,0x1
    13de:	cbe58593          	addi	a1,a1,-834 # 2098 <schedule_dm+0x328>
    13e2:	4509                	li	a0,2
    13e4:	fffff097          	auipc	ra,0xfffff
    13e8:	758080e7          	jalr	1880(ra) # b3c <fprintf>
        exit(1);
    13ec:	4505                	li	a0,1
    13ee:	fffff097          	auipc	ra,0xfffff
    13f2:	260080e7          	jalr	608(ra) # 64e <exit>
    }

    struct thread *to_remove = list_entry(current, struct thread, thread_list);
    13f6:	00001797          	auipc	a5,0x1
    13fa:	e7a78793          	addi	a5,a5,-390 # 2270 <current>
    13fe:	639c                	ld	a5,0(a5)
    1400:	fef43423          	sd	a5,-24(s0)
    1404:	fe843783          	ld	a5,-24(s0)
    1408:	fd878793          	addi	a5,a5,-40
    140c:	fef43023          	sd	a5,-32(s0)
    int consume_ticks = cancelthrdstop(to_remove->thrdstop_context_id, 1);
    1410:	fe043783          	ld	a5,-32(s0)
    1414:	5f9c                	lw	a5,56(a5)
    1416:	4585                	li	a1,1
    1418:	853e                	mv	a0,a5
    141a:	fffff097          	auipc	ra,0xfffff
    141e:	2e4080e7          	jalr	740(ra) # 6fe <cancelthrdstop>
    1422:	87aa                	mv	a5,a0
    1424:	fcf42e23          	sw	a5,-36(s0)
    threading_system_time += consume_ticks;
    1428:	00001797          	auipc	a5,0x1
    142c:	e5078793          	addi	a5,a5,-432 # 2278 <threading_system_time>
    1430:	439c                	lw	a5,0(a5)
    1432:	fdc42703          	lw	a4,-36(s0)
    1436:	9fb9                	addw	a5,a5,a4
    1438:	0007871b          	sext.w	a4,a5
    143c:	00001797          	auipc	a5,0x1
    1440:	e3c78793          	addi	a5,a5,-452 # 2278 <threading_system_time>
    1444:	c398                	sw	a4,0(a5)

    __release();
    1446:	00000097          	auipc	ra,0x0
    144a:	e16080e7          	jalr	-490(ra) # 125c <__release>
    __thread_exit(to_remove);
    144e:	fe043503          	ld	a0,-32(s0)
    1452:	00000097          	auipc	ra,0x0
    1456:	ef2080e7          	jalr	-270(ra) # 1344 <__thread_exit>
}
    145a:	0001                	nop
    145c:	70a2                	ld	ra,40(sp)
    145e:	7402                	ld	s0,32(sp)
    1460:	6145                	addi	sp,sp,48
    1462:	8082                	ret

0000000000001464 <__finish_current>:

void __finish_current()
{
    1464:	7179                	addi	sp,sp,-48
    1466:	f406                	sd	ra,40(sp)
    1468:	f022                	sd	s0,32(sp)
    146a:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    146c:	00001797          	auipc	a5,0x1
    1470:	e0478793          	addi	a5,a5,-508 # 2270 <current>
    1474:	639c                	ld	a5,0(a5)
    1476:	fef43423          	sd	a5,-24(s0)
    147a:	fe843783          	ld	a5,-24(s0)
    147e:	fd878793          	addi	a5,a5,-40
    1482:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    1486:	fe043783          	ld	a5,-32(s0)
    148a:	4bbc                	lw	a5,80(a5)
    148c:	37fd                	addiw	a5,a5,-1
    148e:	0007871b          	sext.w	a4,a5
    1492:	fe043783          	ld	a5,-32(s0)
    1496:	cbb8                	sw	a4,80(a5)

    printf("thread#%d finish at %d\n",
    1498:	fe043783          	ld	a5,-32(s0)
    149c:	5fd8                	lw	a4,60(a5)
    149e:	00001797          	auipc	a5,0x1
    14a2:	dda78793          	addi	a5,a5,-550 # 2278 <threading_system_time>
    14a6:	4390                	lw	a2,0(a5)
    14a8:	fe043783          	ld	a5,-32(s0)
    14ac:	4bbc                	lw	a5,80(a5)
    14ae:	86be                	mv	a3,a5
    14b0:	85ba                	mv	a1,a4
    14b2:	00001517          	auipc	a0,0x1
    14b6:	c1e50513          	addi	a0,a0,-994 # 20d0 <schedule_dm+0x360>
    14ba:	fffff097          	auipc	ra,0xfffff
    14be:	6da080e7          	jalr	1754(ra) # b94 <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
    14c2:	fe043783          	ld	a5,-32(s0)
    14c6:	4bbc                	lw	a5,80(a5)
    14c8:	04f05563          	blez	a5,1512 <__finish_current+0xae>
        struct list_head *to_remove = current;
    14cc:	00001797          	auipc	a5,0x1
    14d0:	da478793          	addi	a5,a5,-604 # 2270 <current>
    14d4:	639c                	ld	a5,0(a5)
    14d6:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    14da:	00001797          	auipc	a5,0x1
    14de:	d9678793          	addi	a5,a5,-618 # 2270 <current>
    14e2:	639c                	ld	a5,0(a5)
    14e4:	6798                	ld	a4,8(a5)
    14e6:	00001797          	auipc	a5,0x1
    14ea:	d8a78793          	addi	a5,a5,-630 # 2270 <current>
    14ee:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    14f0:	fd843503          	ld	a0,-40(s0)
    14f4:	00000097          	auipc	ra,0x0
    14f8:	ae4080e7          	jalr	-1308(ra) # fd8 <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    14fc:	fe043783          	ld	a5,-32(s0)
    1500:	4fbc                	lw	a5,88(a5)
    1502:	85be                	mv	a1,a5
    1504:	fe043503          	ld	a0,-32(s0)
    1508:	00000097          	auipc	ra,0x0
    150c:	cd4080e7          	jalr	-812(ra) # 11dc <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
    1510:	a039                	j	151e <__finish_current+0xba>
        __thread_exit(current_thread);
    1512:	fe043503          	ld	a0,-32(s0)
    1516:	00000097          	auipc	ra,0x0
    151a:	e2e080e7          	jalr	-466(ra) # 1344 <__thread_exit>
}
    151e:	0001                	nop
    1520:	70a2                	ld	ra,40(sp)
    1522:	7402                	ld	s0,32(sp)
    1524:	6145                	addi	sp,sp,48
    1526:	8082                	ret

0000000000001528 <__rt_finish_current>:
void __rt_finish_current()
{
    1528:	7179                	addi	sp,sp,-48
    152a:	f406                	sd	ra,40(sp)
    152c:	f022                	sd	s0,32(sp)
    152e:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    1530:	00001797          	auipc	a5,0x1
    1534:	d4078793          	addi	a5,a5,-704 # 2270 <current>
    1538:	639c                	ld	a5,0(a5)
    153a:	fef43423          	sd	a5,-24(s0)
    153e:	fe843783          	ld	a5,-24(s0)
    1542:	fd878793          	addi	a5,a5,-40
    1546:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    154a:	fe043783          	ld	a5,-32(s0)
    154e:	4bbc                	lw	a5,80(a5)
    1550:	37fd                	addiw	a5,a5,-1
    1552:	0007871b          	sext.w	a4,a5
    1556:	fe043783          	ld	a5,-32(s0)
    155a:	cbb8                	sw	a4,80(a5)

    printf("thread#%d finish one cycle at %d: %d cycles left\n",
    155c:	fe043783          	ld	a5,-32(s0)
    1560:	5fd8                	lw	a4,60(a5)
    1562:	00001797          	auipc	a5,0x1
    1566:	d1678793          	addi	a5,a5,-746 # 2278 <threading_system_time>
    156a:	4390                	lw	a2,0(a5)
    156c:	fe043783          	ld	a5,-32(s0)
    1570:	4bbc                	lw	a5,80(a5)
    1572:	86be                	mv	a3,a5
    1574:	85ba                	mv	a1,a4
    1576:	00001517          	auipc	a0,0x1
    157a:	b7250513          	addi	a0,a0,-1166 # 20e8 <schedule_dm+0x378>
    157e:	fffff097          	auipc	ra,0xfffff
    1582:	616080e7          	jalr	1558(ra) # b94 <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
    1586:	fe043783          	ld	a5,-32(s0)
    158a:	4bbc                	lw	a5,80(a5)
    158c:	04f05f63          	blez	a5,15ea <__rt_finish_current+0xc2>
        struct list_head *to_remove = current;
    1590:	00001797          	auipc	a5,0x1
    1594:	ce078793          	addi	a5,a5,-800 # 2270 <current>
    1598:	639c                	ld	a5,0(a5)
    159a:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    159e:	00001797          	auipc	a5,0x1
    15a2:	cd278793          	addi	a5,a5,-814 # 2270 <current>
    15a6:	639c                	ld	a5,0(a5)
    15a8:	6798                	ld	a4,8(a5)
    15aa:	00001797          	auipc	a5,0x1
    15ae:	cc678793          	addi	a5,a5,-826 # 2270 <current>
    15b2:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    15b4:	fd843503          	ld	a0,-40(s0)
    15b8:	00000097          	auipc	ra,0x0
    15bc:	a20080e7          	jalr	-1504(ra) # fd8 <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    15c0:	fe043783          	ld	a5,-32(s0)
    15c4:	4fbc                	lw	a5,88(a5)
    15c6:	85be                	mv	a1,a5
    15c8:	fe043503          	ld	a0,-32(s0)
    15cc:	00000097          	auipc	ra,0x0
    15d0:	c10080e7          	jalr	-1008(ra) # 11dc <thread_add_at>
        if (!current_thread->cbs.is_hard_rt) {
    15d4:	fe043783          	ld	a5,-32(s0)
    15d8:	57fc                	lw	a5,108(a5)
    15da:	ef91                	bnez	a5,15f6 <__rt_finish_current+0xce>
            current_thread->cbs.remaining_budget = current_thread->cbs.budget;
    15dc:	fe043783          	ld	a5,-32(s0)
    15e0:	53f8                	lw	a4,100(a5)
    15e2:	fe043783          	ld	a5,-32(s0)
    15e6:	d7b8                	sw	a4,104(a5)
        }
    } else {
        __thread_exit(current_thread);
    }
}
    15e8:	a039                	j	15f6 <__rt_finish_current+0xce>
        __thread_exit(current_thread);
    15ea:	fe043503          	ld	a0,-32(s0)
    15ee:	00000097          	auipc	ra,0x0
    15f2:	d56080e7          	jalr	-682(ra) # 1344 <__thread_exit>
}
    15f6:	0001                	nop
    15f8:	70a2                	ld	ra,40(sp)
    15fa:	7402                	ld	s0,32(sp)
    15fc:	6145                	addi	sp,sp,48
    15fe:	8082                	ret

0000000000001600 <switch_handler>:

void switch_handler(void *arg)
{
    1600:	7139                	addi	sp,sp,-64
    1602:	fc06                	sd	ra,56(sp)
    1604:	f822                	sd	s0,48(sp)
    1606:	0080                	addi	s0,sp,64
    1608:	fca43423          	sd	a0,-56(s0)
    uint64 elapsed_time = (uint64)arg;
    160c:	fc843783          	ld	a5,-56(s0)
    1610:	fef43423          	sd	a5,-24(s0)
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    1614:	00001797          	auipc	a5,0x1
    1618:	c5c78793          	addi	a5,a5,-932 # 2270 <current>
    161c:	639c                	ld	a5,0(a5)
    161e:	fef43023          	sd	a5,-32(s0)
    1622:	fe043783          	ld	a5,-32(s0)
    1626:	fd878793          	addi	a5,a5,-40
    162a:	fcf43c23          	sd	a5,-40(s0)

    threading_system_time += elapsed_time;
    162e:	fe843783          	ld	a5,-24(s0)
    1632:	0007871b          	sext.w	a4,a5
    1636:	00001797          	auipc	a5,0x1
    163a:	c4278793          	addi	a5,a5,-958 # 2278 <threading_system_time>
    163e:	439c                	lw	a5,0(a5)
    1640:	2781                	sext.w	a5,a5
    1642:	9fb9                	addw	a5,a5,a4
    1644:	2781                	sext.w	a5,a5
    1646:	0007871b          	sext.w	a4,a5
    164a:	00001797          	auipc	a5,0x1
    164e:	c2e78793          	addi	a5,a5,-978 # 2278 <threading_system_time>
    1652:	c398                	sw	a4,0(a5)
     __release();
    1654:	00000097          	auipc	ra,0x0
    1658:	c08080e7          	jalr	-1016(ra) # 125c <__release>
    current_thread->remaining_time -= elapsed_time;
    165c:	fd843783          	ld	a5,-40(s0)
    1660:	4bfc                	lw	a5,84(a5)
    1662:	0007871b          	sext.w	a4,a5
    1666:	fe843783          	ld	a5,-24(s0)
    166a:	2781                	sext.w	a5,a5
    166c:	40f707bb          	subw	a5,a4,a5
    1670:	2781                	sext.w	a5,a5
    1672:	0007871b          	sext.w	a4,a5
    1676:	fd843783          	ld	a5,-40(s0)
    167a:	cbf8                	sw	a4,84(a5)
    if (!current_thread->cbs.is_hard_rt) {
    167c:	fd843783          	ld	a5,-40(s0)
    1680:	57fc                	lw	a5,108(a5)
    1682:	e38d                	bnez	a5,16a4 <switch_handler+0xa4>
        current_thread->cbs.remaining_budget -= elapsed_time;
    1684:	fd843783          	ld	a5,-40(s0)
    1688:	57bc                	lw	a5,104(a5)
    168a:	0007871b          	sext.w	a4,a5
    168e:	fe843783          	ld	a5,-24(s0)
    1692:	2781                	sext.w	a5,a5
    1694:	40f707bb          	subw	a5,a4,a5
    1698:	2781                	sext.w	a5,a5
    169a:	0007871b          	sext.w	a4,a5
    169e:	fd843783          	ld	a5,-40(s0)
    16a2:	d7b8                	sw	a4,104(a5)
    }
    if (current_thread->is_real_time)
    16a4:	fd843783          	ld	a5,-40(s0)
    16a8:	43bc                	lw	a5,64(a5)
    16aa:	c3ad                	beqz	a5,170c <switch_handler+0x10c>
        if (threading_system_time > current_thread->current_deadline || 
    16ac:	fd843783          	ld	a5,-40(s0)
    16b0:	4fb8                	lw	a4,88(a5)
    16b2:	00001797          	auipc	a5,0x1
    16b6:	bc678793          	addi	a5,a5,-1082 # 2278 <threading_system_time>
    16ba:	439c                	lw	a5,0(a5)
    16bc:	02f74163          	blt	a4,a5,16de <switch_handler+0xde>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    16c0:	fd843783          	ld	a5,-40(s0)
    16c4:	4fb8                	lw	a4,88(a5)
    16c6:	00001797          	auipc	a5,0x1
    16ca:	bb278793          	addi	a5,a5,-1102 # 2278 <threading_system_time>
    16ce:	439c                	lw	a5,0(a5)
        if (threading_system_time > current_thread->current_deadline || 
    16d0:	02f71e63          	bne	a4,a5,170c <switch_handler+0x10c>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    16d4:	fd843783          	ld	a5,-40(s0)
    16d8:	4bfc                	lw	a5,84(a5)
    16da:	02f05963          	blez	a5,170c <switch_handler+0x10c>
            printf("thread#%d misses a deadline at %d in swicth\n", current_thread->ID, threading_system_time);
    16de:	fd843783          	ld	a5,-40(s0)
    16e2:	5fd8                	lw	a4,60(a5)
    16e4:	00001797          	auipc	a5,0x1
    16e8:	b9478793          	addi	a5,a5,-1132 # 2278 <threading_system_time>
    16ec:	439c                	lw	a5,0(a5)
    16ee:	863e                	mv	a2,a5
    16f0:	85ba                	mv	a1,a4
    16f2:	00001517          	auipc	a0,0x1
    16f6:	a2e50513          	addi	a0,a0,-1490 # 2120 <schedule_dm+0x3b0>
    16fa:	fffff097          	auipc	ra,0xfffff
    16fe:	49a080e7          	jalr	1178(ra) # b94 <printf>
            exit(0);
    1702:	4501                	li	a0,0
    1704:	fffff097          	auipc	ra,0xfffff
    1708:	f4a080e7          	jalr	-182(ra) # 64e <exit>
        }

    if (current_thread->remaining_time <= 0) {
    170c:	fd843783          	ld	a5,-40(s0)
    1710:	4bfc                	lw	a5,84(a5)
    1712:	02f04063          	bgtz	a5,1732 <switch_handler+0x132>
        if (current_thread->is_real_time)
    1716:	fd843783          	ld	a5,-40(s0)
    171a:	43bc                	lw	a5,64(a5)
    171c:	c791                	beqz	a5,1728 <switch_handler+0x128>
            __rt_finish_current();
    171e:	00000097          	auipc	ra,0x0
    1722:	e0a080e7          	jalr	-502(ra) # 1528 <__rt_finish_current>
    1726:	a881                	j	1776 <switch_handler+0x176>
        else
            __finish_current();
    1728:	00000097          	auipc	ra,0x0
    172c:	d3c080e7          	jalr	-708(ra) # 1464 <__finish_current>
    1730:	a099                	j	1776 <switch_handler+0x176>
    } else {
        // move the current thread to the end of the run_queue
        struct list_head *to_remove = current;
    1732:	00001797          	auipc	a5,0x1
    1736:	b3e78793          	addi	a5,a5,-1218 # 2270 <current>
    173a:	639c                	ld	a5,0(a5)
    173c:	fcf43823          	sd	a5,-48(s0)
        current = current->prev;
    1740:	00001797          	auipc	a5,0x1
    1744:	b3078793          	addi	a5,a5,-1232 # 2270 <current>
    1748:	639c                	ld	a5,0(a5)
    174a:	6798                	ld	a4,8(a5)
    174c:	00001797          	auipc	a5,0x1
    1750:	b2478793          	addi	a5,a5,-1244 # 2270 <current>
    1754:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    1756:	fd043503          	ld	a0,-48(s0)
    175a:	00000097          	auipc	ra,0x0
    175e:	87e080e7          	jalr	-1922(ra) # fd8 <list_del>
        list_add_tail(to_remove, &run_queue);
    1762:	00001597          	auipc	a1,0x1
    1766:	ac658593          	addi	a1,a1,-1338 # 2228 <run_queue>
    176a:	fd043503          	ld	a0,-48(s0)
    176e:	00000097          	auipc	ra,0x0
    1772:	80e080e7          	jalr	-2034(ra) # f7c <list_add_tail>
    }

    __release();
    1776:	00000097          	auipc	ra,0x0
    177a:	ae6080e7          	jalr	-1306(ra) # 125c <__release>
    __schedule();
    177e:	00000097          	auipc	ra,0x0
    1782:	1be080e7          	jalr	446(ra) # 193c <__schedule>
    __dispatch();
    1786:	00000097          	auipc	ra,0x0
    178a:	026080e7          	jalr	38(ra) # 17ac <__dispatch>
    thrdresume(main_thrd_id);
    178e:	00001797          	auipc	a5,0x1
    1792:	aba78793          	addi	a5,a5,-1350 # 2248 <main_thrd_id>
    1796:	439c                	lw	a5,0(a5)
    1798:	853e                	mv	a0,a5
    179a:	fffff097          	auipc	ra,0xfffff
    179e:	f5c080e7          	jalr	-164(ra) # 6f6 <thrdresume>
}
    17a2:	0001                	nop
    17a4:	70e2                	ld	ra,56(sp)
    17a6:	7442                	ld	s0,48(sp)
    17a8:	6121                	addi	sp,sp,64
    17aa:	8082                	ret

00000000000017ac <__dispatch>:

void __dispatch()
{
    17ac:	7179                	addi	sp,sp,-48
    17ae:	f406                	sd	ra,40(sp)
    17b0:	f022                	sd	s0,32(sp)
    17b2:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    17b4:	00001797          	auipc	a5,0x1
    17b8:	abc78793          	addi	a5,a5,-1348 # 2270 <current>
    17bc:	6398                	ld	a4,0(a5)
    17be:	00001797          	auipc	a5,0x1
    17c2:	a6a78793          	addi	a5,a5,-1430 # 2228 <run_queue>
    17c6:	16f70663          	beq	a4,a5,1932 <__dispatch+0x186>
    if (allocated_time < 0) {
        fprintf(2, "[FATAL] allocated_time is negative\n");
        exit(1);
    }

    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    17ca:	00001797          	auipc	a5,0x1
    17ce:	aa678793          	addi	a5,a5,-1370 # 2270 <current>
    17d2:	639c                	ld	a5,0(a5)
    17d4:	fef43423          	sd	a5,-24(s0)
    17d8:	fe843783          	ld	a5,-24(s0)
    17dc:	fd878793          	addi	a5,a5,-40
    17e0:	fef43023          	sd	a5,-32(s0)
    if (current_thread->is_real_time && allocated_time == 0) {
    17e4:	fe043783          	ld	a5,-32(s0)
    17e8:	43bc                	lw	a5,64(a5)
    17ea:	cf85                	beqz	a5,1822 <__dispatch+0x76>
    17ec:	00001797          	auipc	a5,0x1
    17f0:	a9478793          	addi	a5,a5,-1388 # 2280 <allocated_time>
    17f4:	639c                	ld	a5,0(a5)
    17f6:	e795                	bnez	a5,1822 <__dispatch+0x76>
        printf("thread#%d misses a deadline at %d in dispatch\n", current_thread->ID, current_thread->current_deadline);
    17f8:	fe043783          	ld	a5,-32(s0)
    17fc:	5fd8                	lw	a4,60(a5)
    17fe:	fe043783          	ld	a5,-32(s0)
    1802:	4fbc                	lw	a5,88(a5)
    1804:	863e                	mv	a2,a5
    1806:	85ba                	mv	a1,a4
    1808:	00001517          	auipc	a0,0x1
    180c:	94850513          	addi	a0,a0,-1720 # 2150 <schedule_dm+0x3e0>
    1810:	fffff097          	auipc	ra,0xfffff
    1814:	384080e7          	jalr	900(ra) # b94 <printf>
        exit(0);
    1818:	4501                	li	a0,0
    181a:	fffff097          	auipc	ra,0xfffff
    181e:	e34080e7          	jalr	-460(ra) # 64e <exit>
    }

    printf("dispatch thread#%d at %d: allocated_time=%d\n", current_thread->ID, threading_system_time, allocated_time);
    1822:	fe043783          	ld	a5,-32(s0)
    1826:	5fd8                	lw	a4,60(a5)
    1828:	00001797          	auipc	a5,0x1
    182c:	a5078793          	addi	a5,a5,-1456 # 2278 <threading_system_time>
    1830:	4390                	lw	a2,0(a5)
    1832:	00001797          	auipc	a5,0x1
    1836:	a4e78793          	addi	a5,a5,-1458 # 2280 <allocated_time>
    183a:	639c                	ld	a5,0(a5)
    183c:	86be                	mv	a3,a5
    183e:	85ba                	mv	a1,a4
    1840:	00001517          	auipc	a0,0x1
    1844:	94050513          	addi	a0,a0,-1728 # 2180 <schedule_dm+0x410>
    1848:	fffff097          	auipc	ra,0xfffff
    184c:	34c080e7          	jalr	844(ra) # b94 <printf>

    if (current_thread->buf_set) {
    1850:	fe043783          	ld	a5,-32(s0)
    1854:	539c                	lw	a5,32(a5)
    1856:	c7a1                	beqz	a5,189e <__dispatch+0xf2>
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    1858:	00001797          	auipc	a5,0x1
    185c:	a2878793          	addi	a5,a5,-1496 # 2280 <allocated_time>
    1860:	639c                	ld	a5,0(a5)
    1862:	0007871b          	sext.w	a4,a5
    1866:	fe043783          	ld	a5,-32(s0)
    186a:	03878593          	addi	a1,a5,56
    186e:	00001797          	auipc	a5,0x1
    1872:	a1278793          	addi	a5,a5,-1518 # 2280 <allocated_time>
    1876:	639c                	ld	a5,0(a5)
    1878:	86be                	mv	a3,a5
    187a:	00000617          	auipc	a2,0x0
    187e:	d8660613          	addi	a2,a2,-634 # 1600 <switch_handler>
    1882:	853a                	mv	a0,a4
    1884:	fffff097          	auipc	ra,0xfffff
    1888:	e6a080e7          	jalr	-406(ra) # 6ee <thrdstop>
        thrdresume(current_thread->thrdstop_context_id);
    188c:	fe043783          	ld	a5,-32(s0)
    1890:	5f9c                	lw	a5,56(a5)
    1892:	853e                	mv	a0,a5
    1894:	fffff097          	auipc	ra,0xfffff
    1898:	e62080e7          	jalr	-414(ra) # 6f6 <thrdresume>
    189c:	a071                	j	1928 <__dispatch+0x17c>
    } else {
        current_thread->buf_set = 1;
    189e:	fe043783          	ld	a5,-32(s0)
    18a2:	4705                	li	a4,1
    18a4:	d398                	sw	a4,32(a5)
        unsigned long new_stack_p = (unsigned long)current_thread->stack_p;
    18a6:	fe043783          	ld	a5,-32(s0)
    18aa:	6f9c                	ld	a5,24(a5)
    18ac:	fcf43c23          	sd	a5,-40(s0)
        current_thread->thrdstop_context_id = -1;
    18b0:	fe043783          	ld	a5,-32(s0)
    18b4:	577d                	li	a4,-1
    18b6:	df98                	sw	a4,56(a5)
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    18b8:	00001797          	auipc	a5,0x1
    18bc:	9c878793          	addi	a5,a5,-1592 # 2280 <allocated_time>
    18c0:	639c                	ld	a5,0(a5)
    18c2:	0007871b          	sext.w	a4,a5
    18c6:	fe043783          	ld	a5,-32(s0)
    18ca:	03878593          	addi	a1,a5,56
    18ce:	00001797          	auipc	a5,0x1
    18d2:	9b278793          	addi	a5,a5,-1614 # 2280 <allocated_time>
    18d6:	639c                	ld	a5,0(a5)
    18d8:	86be                	mv	a3,a5
    18da:	00000617          	auipc	a2,0x0
    18de:	d2660613          	addi	a2,a2,-730 # 1600 <switch_handler>
    18e2:	853a                	mv	a0,a4
    18e4:	fffff097          	auipc	ra,0xfffff
    18e8:	e0a080e7          	jalr	-502(ra) # 6ee <thrdstop>
        if (current_thread->thrdstop_context_id < 0) {
    18ec:	fe043783          	ld	a5,-32(s0)
    18f0:	5f9c                	lw	a5,56(a5)
    18f2:	0207d063          	bgez	a5,1912 <__dispatch+0x166>
            fprintf(2, "[ERROR] number of threads may exceed MAX_THRD_NUM\n");
    18f6:	00001597          	auipc	a1,0x1
    18fa:	8ba58593          	addi	a1,a1,-1862 # 21b0 <schedule_dm+0x440>
    18fe:	4509                	li	a0,2
    1900:	fffff097          	auipc	ra,0xfffff
    1904:	23c080e7          	jalr	572(ra) # b3c <fprintf>
            exit(1);
    1908:	4505                	li	a0,1
    190a:	fffff097          	auipc	ra,0xfffff
    190e:	d44080e7          	jalr	-700(ra) # 64e <exit>
        }

        // set sp to stack pointer of current thread.
        asm volatile("mv sp, %0"
    1912:	fd843783          	ld	a5,-40(s0)
    1916:	813e                	mv	sp,a5
                     :
                     : "r"(new_stack_p));
        current_thread->fp(current_thread->arg);
    1918:	fe043783          	ld	a5,-32(s0)
    191c:	6398                	ld	a4,0(a5)
    191e:	fe043783          	ld	a5,-32(s0)
    1922:	679c                	ld	a5,8(a5)
    1924:	853e                	mv	a0,a5
    1926:	9702                	jalr	a4
    }
    thread_exit();
    1928:	00000097          	auipc	ra,0x0
    192c:	a94080e7          	jalr	-1388(ra) # 13bc <thread_exit>
    1930:	a011                	j	1934 <__dispatch+0x188>
        return;
    1932:	0001                	nop
}
    1934:	70a2                	ld	ra,40(sp)
    1936:	7402                	ld	s0,32(sp)
    1938:	6145                	addi	sp,sp,48
    193a:	8082                	ret

000000000000193c <__schedule>:

void __schedule()
{
    193c:	711d                	addi	sp,sp,-96
    193e:	ec86                	sd	ra,88(sp)
    1940:	e8a2                	sd	s0,80(sp)
    1942:	1080                	addi	s0,sp,96
    struct threads_sched_args args = {
    1944:	00001797          	auipc	a5,0x1
    1948:	93478793          	addi	a5,a5,-1740 # 2278 <threading_system_time>
    194c:	439c                	lw	a5,0(a5)
    194e:	fcf42c23          	sw	a5,-40(s0)
    1952:	4789                	li	a5,2
    1954:	fcf42e23          	sw	a5,-36(s0)
    1958:	00001797          	auipc	a5,0x1
    195c:	8d078793          	addi	a5,a5,-1840 # 2228 <run_queue>
    1960:	fef43023          	sd	a5,-32(s0)
    1964:	00001797          	auipc	a5,0x1
    1968:	8d478793          	addi	a5,a5,-1836 # 2238 <release_queue>
    196c:	fef43423          	sd	a5,-24(s0)
#ifdef THREAD_SCHEDULER_EDF_CBS
    r = schedule_edf_cbs(args);
#endif

#ifdef THREAD_SCHEDULER_DM
    r = schedule_dm(args);
    1970:	fd843783          	ld	a5,-40(s0)
    1974:	faf43023          	sd	a5,-96(s0)
    1978:	fe043783          	ld	a5,-32(s0)
    197c:	faf43423          	sd	a5,-88(s0)
    1980:	fe843783          	ld	a5,-24(s0)
    1984:	faf43823          	sd	a5,-80(s0)
    1988:	fa040793          	addi	a5,s0,-96
    198c:	853e                	mv	a0,a5
    198e:	00000097          	auipc	ra,0x0
    1992:	3e2080e7          	jalr	994(ra) # 1d70 <schedule_dm>
    1996:	872a                	mv	a4,a0
    1998:	87ae                	mv	a5,a1
    199a:	fce43423          	sd	a4,-56(s0)
    199e:	fcf43823          	sd	a5,-48(s0)
//     r = schedule_edf_cbs(args);
// #else
//     r = schedule_default(args);
// #endif

    current = r.scheduled_thread_list_member;
    19a2:	fc843703          	ld	a4,-56(s0)
    19a6:	00001797          	auipc	a5,0x1
    19aa:	8ca78793          	addi	a5,a5,-1846 # 2270 <current>
    19ae:	e398                	sd	a4,0(a5)
    allocated_time = r.allocated_time;
    19b0:	fd042783          	lw	a5,-48(s0)
    19b4:	873e                	mv	a4,a5
    19b6:	00001797          	auipc	a5,0x1
    19ba:	8ca78793          	addi	a5,a5,-1846 # 2280 <allocated_time>
    19be:	e398                	sd	a4,0(a5)
}
    19c0:	0001                	nop
    19c2:	60e6                	ld	ra,88(sp)
    19c4:	6446                	ld	s0,80(sp)
    19c6:	6125                	addi	sp,sp,96
    19c8:	8082                	ret

00000000000019ca <back_to_main_handler>:

void back_to_main_handler(void *arg)
{
    19ca:	1101                	addi	sp,sp,-32
    19cc:	ec06                	sd	ra,24(sp)
    19ce:	e822                	sd	s0,16(sp)
    19d0:	1000                	addi	s0,sp,32
    19d2:	fea43423          	sd	a0,-24(s0)
    sleeping = 0;
    19d6:	00001797          	auipc	a5,0x1
    19da:	8a678793          	addi	a5,a5,-1882 # 227c <sleeping>
    19de:	0007a023          	sw	zero,0(a5)
    threading_system_time += (uint64)arg;
    19e2:	fe843783          	ld	a5,-24(s0)
    19e6:	0007871b          	sext.w	a4,a5
    19ea:	00001797          	auipc	a5,0x1
    19ee:	88e78793          	addi	a5,a5,-1906 # 2278 <threading_system_time>
    19f2:	439c                	lw	a5,0(a5)
    19f4:	2781                	sext.w	a5,a5
    19f6:	9fb9                	addw	a5,a5,a4
    19f8:	2781                	sext.w	a5,a5
    19fa:	0007871b          	sext.w	a4,a5
    19fe:	00001797          	auipc	a5,0x1
    1a02:	87a78793          	addi	a5,a5,-1926 # 2278 <threading_system_time>
    1a06:	c398                	sw	a4,0(a5)
    thrdresume(main_thrd_id);
    1a08:	00001797          	auipc	a5,0x1
    1a0c:	84078793          	addi	a5,a5,-1984 # 2248 <main_thrd_id>
    1a10:	439c                	lw	a5,0(a5)
    1a12:	853e                	mv	a0,a5
    1a14:	fffff097          	auipc	ra,0xfffff
    1a18:	ce2080e7          	jalr	-798(ra) # 6f6 <thrdresume>
}
    1a1c:	0001                	nop
    1a1e:	60e2                	ld	ra,24(sp)
    1a20:	6442                	ld	s0,16(sp)
    1a22:	6105                	addi	sp,sp,32
    1a24:	8082                	ret

0000000000001a26 <thread_start_threading>:

void thread_start_threading()
{
    1a26:	1141                	addi	sp,sp,-16
    1a28:	e406                	sd	ra,8(sp)
    1a2a:	e022                	sd	s0,0(sp)
    1a2c:	0800                	addi	s0,sp,16
    threading_system_time = 0;
    1a2e:	00001797          	auipc	a5,0x1
    1a32:	84a78793          	addi	a5,a5,-1974 # 2278 <threading_system_time>
    1a36:	0007a023          	sw	zero,0(a5)
    current = &run_queue;
    1a3a:	00001797          	auipc	a5,0x1
    1a3e:	83678793          	addi	a5,a5,-1994 # 2270 <current>
    1a42:	00000717          	auipc	a4,0x0
    1a46:	7e670713          	addi	a4,a4,2022 # 2228 <run_queue>
    1a4a:	e398                	sd	a4,0(a5)

    // call thrdstop just for obtain an ID
    thrdstop(1000, &main_thrd_id, back_to_main_handler, (void *)0);
    1a4c:	4681                	li	a3,0
    1a4e:	00000617          	auipc	a2,0x0
    1a52:	f7c60613          	addi	a2,a2,-132 # 19ca <back_to_main_handler>
    1a56:	00000597          	auipc	a1,0x0
    1a5a:	7f258593          	addi	a1,a1,2034 # 2248 <main_thrd_id>
    1a5e:	3e800513          	li	a0,1000
    1a62:	fffff097          	auipc	ra,0xfffff
    1a66:	c8c080e7          	jalr	-884(ra) # 6ee <thrdstop>
    cancelthrdstop(main_thrd_id, 0);
    1a6a:	00000797          	auipc	a5,0x0
    1a6e:	7de78793          	addi	a5,a5,2014 # 2248 <main_thrd_id>
    1a72:	439c                	lw	a5,0(a5)
    1a74:	4581                	li	a1,0
    1a76:	853e                	mv	a0,a5
    1a78:	fffff097          	auipc	ra,0xfffff
    1a7c:	c86080e7          	jalr	-890(ra) # 6fe <cancelthrdstop>

    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    1a80:	a0c9                	j	1b42 <thread_start_threading+0x11c>
        __release();
    1a82:	fffff097          	auipc	ra,0xfffff
    1a86:	7da080e7          	jalr	2010(ra) # 125c <__release>
        __schedule();
    1a8a:	00000097          	auipc	ra,0x0
    1a8e:	eb2080e7          	jalr	-334(ra) # 193c <__schedule>
        cancelthrdstop(main_thrd_id, 0);
    1a92:	00000797          	auipc	a5,0x0
    1a96:	7b678793          	addi	a5,a5,1974 # 2248 <main_thrd_id>
    1a9a:	439c                	lw	a5,0(a5)
    1a9c:	4581                	li	a1,0
    1a9e:	853e                	mv	a0,a5
    1aa0:	fffff097          	auipc	ra,0xfffff
    1aa4:	c5e080e7          	jalr	-930(ra) # 6fe <cancelthrdstop>
        __dispatch();
    1aa8:	00000097          	auipc	ra,0x0
    1aac:	d04080e7          	jalr	-764(ra) # 17ac <__dispatch>

        if (list_empty(&run_queue) && list_empty(&release_queue)) {
    1ab0:	00000517          	auipc	a0,0x0
    1ab4:	77850513          	addi	a0,a0,1912 # 2228 <run_queue>
    1ab8:	fffff097          	auipc	ra,0xfffff
    1abc:	56a080e7          	jalr	1386(ra) # 1022 <list_empty>
    1ac0:	87aa                	mv	a5,a0
    1ac2:	cb99                	beqz	a5,1ad8 <thread_start_threading+0xb2>
    1ac4:	00000517          	auipc	a0,0x0
    1ac8:	77450513          	addi	a0,a0,1908 # 2238 <release_queue>
    1acc:	fffff097          	auipc	ra,0xfffff
    1ad0:	556080e7          	jalr	1366(ra) # 1022 <list_empty>
    1ad4:	87aa                	mv	a5,a0
    1ad6:	ebd9                	bnez	a5,1b6c <thread_start_threading+0x146>
            break;
        }

        // no thread in run_queue, release_queue not empty
        printf("run_queue is empty, sleep for %d ticks\n", allocated_time);
    1ad8:	00000797          	auipc	a5,0x0
    1adc:	7a878793          	addi	a5,a5,1960 # 2280 <allocated_time>
    1ae0:	639c                	ld	a5,0(a5)
    1ae2:	85be                	mv	a1,a5
    1ae4:	00000517          	auipc	a0,0x0
    1ae8:	70450513          	addi	a0,a0,1796 # 21e8 <schedule_dm+0x478>
    1aec:	fffff097          	auipc	ra,0xfffff
    1af0:	0a8080e7          	jalr	168(ra) # b94 <printf>
        sleeping = 1;
    1af4:	00000797          	auipc	a5,0x0
    1af8:	78878793          	addi	a5,a5,1928 # 227c <sleeping>
    1afc:	4705                	li	a4,1
    1afe:	c398                	sw	a4,0(a5)
        thrdstop(allocated_time, &main_thrd_id, back_to_main_handler, (void *)allocated_time);
    1b00:	00000797          	auipc	a5,0x0
    1b04:	78078793          	addi	a5,a5,1920 # 2280 <allocated_time>
    1b08:	639c                	ld	a5,0(a5)
    1b0a:	0007871b          	sext.w	a4,a5
    1b0e:	00000797          	auipc	a5,0x0
    1b12:	77278793          	addi	a5,a5,1906 # 2280 <allocated_time>
    1b16:	639c                	ld	a5,0(a5)
    1b18:	86be                	mv	a3,a5
    1b1a:	00000617          	auipc	a2,0x0
    1b1e:	eb060613          	addi	a2,a2,-336 # 19ca <back_to_main_handler>
    1b22:	00000597          	auipc	a1,0x0
    1b26:	72658593          	addi	a1,a1,1830 # 2248 <main_thrd_id>
    1b2a:	853a                	mv	a0,a4
    1b2c:	fffff097          	auipc	ra,0xfffff
    1b30:	bc2080e7          	jalr	-1086(ra) # 6ee <thrdstop>
        while (sleeping) {
    1b34:	0001                	nop
    1b36:	00000797          	auipc	a5,0x0
    1b3a:	74678793          	addi	a5,a5,1862 # 227c <sleeping>
    1b3e:	439c                	lw	a5,0(a5)
    1b40:	fbfd                	bnez	a5,1b36 <thread_start_threading+0x110>
    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    1b42:	00000517          	auipc	a0,0x0
    1b46:	6e650513          	addi	a0,a0,1766 # 2228 <run_queue>
    1b4a:	fffff097          	auipc	ra,0xfffff
    1b4e:	4d8080e7          	jalr	1240(ra) # 1022 <list_empty>
    1b52:	87aa                	mv	a5,a0
    1b54:	d79d                	beqz	a5,1a82 <thread_start_threading+0x5c>
    1b56:	00000517          	auipc	a0,0x0
    1b5a:	6e250513          	addi	a0,a0,1762 # 2238 <release_queue>
    1b5e:	fffff097          	auipc	ra,0xfffff
    1b62:	4c4080e7          	jalr	1220(ra) # 1022 <list_empty>
    1b66:	87aa                	mv	a5,a0
    1b68:	df89                	beqz	a5,1a82 <thread_start_threading+0x5c>
            // zzz...
        }
    }
}
    1b6a:	a011                	j	1b6e <thread_start_threading+0x148>
            break;
    1b6c:	0001                	nop
}
    1b6e:	0001                	nop
    1b70:	60a2                	ld	ra,8(sp)
    1b72:	6402                	ld	s0,0(sp)
    1b74:	0141                	addi	sp,sp,16
    1b76:	8082                	ret

0000000000001b78 <__list_add>:
{
    1b78:	7179                	addi	sp,sp,-48
    1b7a:	f422                	sd	s0,40(sp)
    1b7c:	1800                	addi	s0,sp,48
    1b7e:	fea43423          	sd	a0,-24(s0)
    1b82:	feb43023          	sd	a1,-32(s0)
    1b86:	fcc43c23          	sd	a2,-40(s0)
    next->prev = new_entry;
    1b8a:	fd843783          	ld	a5,-40(s0)
    1b8e:	fe843703          	ld	a4,-24(s0)
    1b92:	e798                	sd	a4,8(a5)
    new_entry->next = next;
    1b94:	fe843783          	ld	a5,-24(s0)
    1b98:	fd843703          	ld	a4,-40(s0)
    1b9c:	e398                	sd	a4,0(a5)
    new_entry->prev = prev;
    1b9e:	fe843783          	ld	a5,-24(s0)
    1ba2:	fe043703          	ld	a4,-32(s0)
    1ba6:	e798                	sd	a4,8(a5)
    prev->next = new_entry;
    1ba8:	fe043783          	ld	a5,-32(s0)
    1bac:	fe843703          	ld	a4,-24(s0)
    1bb0:	e398                	sd	a4,0(a5)
}
    1bb2:	0001                	nop
    1bb4:	7422                	ld	s0,40(sp)
    1bb6:	6145                	addi	sp,sp,48
    1bb8:	8082                	ret

0000000000001bba <list_add_tail>:
{
    1bba:	1101                	addi	sp,sp,-32
    1bbc:	ec06                	sd	ra,24(sp)
    1bbe:	e822                	sd	s0,16(sp)
    1bc0:	1000                	addi	s0,sp,32
    1bc2:	fea43423          	sd	a0,-24(s0)
    1bc6:	feb43023          	sd	a1,-32(s0)
    __list_add(new_entry, head->prev, head);
    1bca:	fe043783          	ld	a5,-32(s0)
    1bce:	679c                	ld	a5,8(a5)
    1bd0:	fe043603          	ld	a2,-32(s0)
    1bd4:	85be                	mv	a1,a5
    1bd6:	fe843503          	ld	a0,-24(s0)
    1bda:	00000097          	auipc	ra,0x0
    1bde:	f9e080e7          	jalr	-98(ra) # 1b78 <__list_add>
}
    1be2:	0001                	nop
    1be4:	60e2                	ld	ra,24(sp)
    1be6:	6442                	ld	s0,16(sp)
    1be8:	6105                	addi	sp,sp,32
    1bea:	8082                	ret

0000000000001bec <__list_del>:
{
    1bec:	1101                	addi	sp,sp,-32
    1bee:	ec22                	sd	s0,24(sp)
    1bf0:	1000                	addi	s0,sp,32
    1bf2:	fea43423          	sd	a0,-24(s0)
    1bf6:	feb43023          	sd	a1,-32(s0)
    next->prev = prev;
    1bfa:	fe043783          	ld	a5,-32(s0)
    1bfe:	fe843703          	ld	a4,-24(s0)
    1c02:	e798                	sd	a4,8(a5)
    prev->next = next;
    1c04:	fe843783          	ld	a5,-24(s0)
    1c08:	fe043703          	ld	a4,-32(s0)
    1c0c:	e398                	sd	a4,0(a5)
}
    1c0e:	0001                	nop
    1c10:	6462                	ld	s0,24(sp)
    1c12:	6105                	addi	sp,sp,32
    1c14:	8082                	ret

0000000000001c16 <list_del>:
{
    1c16:	1101                	addi	sp,sp,-32
    1c18:	ec06                	sd	ra,24(sp)
    1c1a:	e822                	sd	s0,16(sp)
    1c1c:	1000                	addi	s0,sp,32
    1c1e:	fea43423          	sd	a0,-24(s0)
    __list_del(entry->prev, entry->next);
    1c22:	fe843783          	ld	a5,-24(s0)
    1c26:	6798                	ld	a4,8(a5)
    1c28:	fe843783          	ld	a5,-24(s0)
    1c2c:	639c                	ld	a5,0(a5)
    1c2e:	85be                	mv	a1,a5
    1c30:	853a                	mv	a0,a4
    1c32:	00000097          	auipc	ra,0x0
    1c36:	fba080e7          	jalr	-70(ra) # 1bec <__list_del>
    entry->next = LIST_POISON1;
    1c3a:	fe843783          	ld	a5,-24(s0)
    1c3e:	00100737          	lui	a4,0x100
    1c42:	10070713          	addi	a4,a4,256 # 100100 <__global_pointer$+0xfd6f0>
    1c46:	e398                	sd	a4,0(a5)
    entry->prev = LIST_POISON2;
    1c48:	fe843783          	ld	a5,-24(s0)
    1c4c:	00200737          	lui	a4,0x200
    1c50:	20070713          	addi	a4,a4,512 # 200200 <__global_pointer$+0x1fd7f0>
    1c54:	e798                	sd	a4,8(a5)
}
    1c56:	0001                	nop
    1c58:	60e2                	ld	ra,24(sp)
    1c5a:	6442                	ld	s0,16(sp)
    1c5c:	6105                	addi	sp,sp,32
    1c5e:	8082                	ret

0000000000001c60 <list_empty>:
{
    1c60:	1101                	addi	sp,sp,-32
    1c62:	ec22                	sd	s0,24(sp)
    1c64:	1000                	addi	s0,sp,32
    1c66:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
    1c6a:	fe843783          	ld	a5,-24(s0)
    1c6e:	639c                	ld	a5,0(a5)
    1c70:	fe843703          	ld	a4,-24(s0)
    1c74:	40f707b3          	sub	a5,a4,a5
    1c78:	0017b793          	seqz	a5,a5
    1c7c:	0ff7f793          	andi	a5,a5,255
    1c80:	2781                	sext.w	a5,a5
}
    1c82:	853e                	mv	a0,a5
    1c84:	6462                	ld	s0,24(sp)
    1c86:	6105                	addi	sp,sp,32
    1c88:	8082                	ret

0000000000001c8a <__check_deadline_miss>:

/* MP3 Part 2 - Real-Time Scheduling*/

#if defined(THREAD_SCHEDULER_EDF_CBS) || defined(THREAD_SCHEDULER_DM)
static struct thread *__check_deadline_miss(struct list_head *run_queue, int current_time)
{
    1c8a:	7139                	addi	sp,sp,-64
    1c8c:	fc22                	sd	s0,56(sp)
    1c8e:	0080                	addi	s0,sp,64
    1c90:	fca43423          	sd	a0,-56(s0)
    1c94:	87ae                	mv	a5,a1
    1c96:	fcf42223          	sw	a5,-60(s0)
    struct thread *th = NULL;
    1c9a:	fe043423          	sd	zero,-24(s0)
    struct thread *thread_missing_deadline = NULL;
    1c9e:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
    1ca2:	fc843783          	ld	a5,-56(s0)
    1ca6:	639c                	ld	a5,0(a5)
    1ca8:	fcf43c23          	sd	a5,-40(s0)
    1cac:	fd843783          	ld	a5,-40(s0)
    1cb0:	fd878793          	addi	a5,a5,-40
    1cb4:	fef43423          	sd	a5,-24(s0)
    1cb8:	a881                	j	1d08 <__check_deadline_miss+0x7e>
        if (th->current_deadline <= current_time) {
    1cba:	fe843783          	ld	a5,-24(s0)
    1cbe:	4fb8                	lw	a4,88(a5)
    1cc0:	fc442783          	lw	a5,-60(s0)
    1cc4:	2781                	sext.w	a5,a5
    1cc6:	02e7c663          	blt	a5,a4,1cf2 <__check_deadline_miss+0x68>
            if (thread_missing_deadline == NULL)
    1cca:	fe043783          	ld	a5,-32(s0)
    1cce:	e791                	bnez	a5,1cda <__check_deadline_miss+0x50>
                thread_missing_deadline = th;
    1cd0:	fe843783          	ld	a5,-24(s0)
    1cd4:	fef43023          	sd	a5,-32(s0)
    1cd8:	a829                	j	1cf2 <__check_deadline_miss+0x68>
            else if (th->ID < thread_missing_deadline->ID)
    1cda:	fe843783          	ld	a5,-24(s0)
    1cde:	5fd8                	lw	a4,60(a5)
    1ce0:	fe043783          	ld	a5,-32(s0)
    1ce4:	5fdc                	lw	a5,60(a5)
    1ce6:	00f75663          	bge	a4,a5,1cf2 <__check_deadline_miss+0x68>
                thread_missing_deadline = th;
    1cea:	fe843783          	ld	a5,-24(s0)
    1cee:	fef43023          	sd	a5,-32(s0)
    list_for_each_entry(th, run_queue, thread_list) {
    1cf2:	fe843783          	ld	a5,-24(s0)
    1cf6:	779c                	ld	a5,40(a5)
    1cf8:	fcf43823          	sd	a5,-48(s0)
    1cfc:	fd043783          	ld	a5,-48(s0)
    1d00:	fd878793          	addi	a5,a5,-40
    1d04:	fef43423          	sd	a5,-24(s0)
    1d08:	fe843783          	ld	a5,-24(s0)
    1d0c:	02878793          	addi	a5,a5,40
    1d10:	fc843703          	ld	a4,-56(s0)
    1d14:	faf713e3          	bne	a4,a5,1cba <__check_deadline_miss+0x30>
        }
    }
    return thread_missing_deadline;
    1d18:	fe043783          	ld	a5,-32(s0)
}
    1d1c:	853e                	mv	a0,a5
    1d1e:	7462                	ld	s0,56(sp)
    1d20:	6121                	addi	sp,sp,64
    1d22:	8082                	ret

0000000000001d24 <__dm_thread_cmp>:
#endif

#ifdef THREAD_SCHEDULER_DM
/* Deadline-Monotonic Scheduling */
static int __dm_thread_cmp(struct thread *a, struct thread *b)
{
    1d24:	1101                	addi	sp,sp,-32
    1d26:	ec22                	sd	s0,24(sp)
    1d28:	1000                	addi	s0,sp,32
    1d2a:	fea43423          	sd	a0,-24(s0)
    1d2e:	feb43023          	sd	a1,-32(s0)
    //To DO
    if (a->deadline != b->deadline)
    1d32:	fe843783          	ld	a5,-24(s0)
    1d36:	47b8                	lw	a4,72(a5)
    1d38:	fe043783          	ld	a5,-32(s0)
    1d3c:	47bc                	lw	a5,72(a5)
    1d3e:	00f70c63          	beq	a4,a5,1d56 <__dm_thread_cmp+0x32>
        return a->deadline - b->deadline;
    1d42:	fe843783          	ld	a5,-24(s0)
    1d46:	47b8                	lw	a4,72(a5)
    1d48:	fe043783          	ld	a5,-32(s0)
    1d4c:	47bc                	lw	a5,72(a5)
    1d4e:	40f707bb          	subw	a5,a4,a5
    1d52:	2781                	sext.w	a5,a5
    1d54:	a811                	j	1d68 <__dm_thread_cmp+0x44>
    return a->ID - b->ID;
    1d56:	fe843783          	ld	a5,-24(s0)
    1d5a:	5fd8                	lw	a4,60(a5)
    1d5c:	fe043783          	ld	a5,-32(s0)
    1d60:	5fdc                	lw	a5,60(a5)
    1d62:	40f707bb          	subw	a5,a4,a5
    1d66:	2781                	sext.w	a5,a5
}
    1d68:	853e                	mv	a0,a5
    1d6a:	6462                	ld	s0,24(sp)
    1d6c:	6105                	addi	sp,sp,32
    1d6e:	8082                	ret

0000000000001d70 <schedule_dm>:

struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    1d70:	7155                	addi	sp,sp,-208
    1d72:	e586                	sd	ra,200(sp)
    1d74:	e1a2                	sd	s0,192(sp)
    1d76:	fd26                	sd	s1,184(sp)
    1d78:	f94a                	sd	s2,176(sp)
    1d7a:	f54e                	sd	s3,168(sp)
    1d7c:	0980                	addi	s0,sp,208
    1d7e:	84aa                	mv	s1,a0
    struct threads_sched_result r;

    // Release any eligible real-time threads
    int closest_release_time = __INT_MAX__;
    1d80:	800007b7          	lui	a5,0x80000
    1d84:	fff7c793          	not	a5,a5
    1d88:	fcf42623          	sw	a5,-52(s0)
    struct release_queue_entry *entry, *tmp;
    list_for_each_entry_safe(entry, tmp, args.release_queue, thread_list) {
    1d8c:	689c                	ld	a5,16(s1)
    1d8e:	639c                	ld	a5,0(a5)
    1d90:	f8f43c23          	sd	a5,-104(s0)
    1d94:	f9843783          	ld	a5,-104(s0)
    1d98:	17e1                	addi	a5,a5,-8
    1d9a:	fcf43023          	sd	a5,-64(s0)
    1d9e:	fc043783          	ld	a5,-64(s0)
    1da2:	679c                	ld	a5,8(a5)
    1da4:	f8f43823          	sd	a5,-112(s0)
    1da8:	f9043783          	ld	a5,-112(s0)
    1dac:	17e1                	addi	a5,a5,-8
    1dae:	faf43c23          	sd	a5,-72(s0)
    1db2:	a0bd                	j	1e20 <schedule_dm+0xb0>
        if (entry->release_time <= args.current_time) {
    1db4:	fc043783          	ld	a5,-64(s0)
    1db8:	4f98                	lw	a4,24(a5)
    1dba:	409c                	lw	a5,0(s1)
    1dbc:	02e7c763          	blt	a5,a4,1dea <schedule_dm+0x7a>
            list_del(&entry->thread_list);
    1dc0:	fc043783          	ld	a5,-64(s0)
    1dc4:	07a1                	addi	a5,a5,8
    1dc6:	853e                	mv	a0,a5
    1dc8:	00000097          	auipc	ra,0x0
    1dcc:	e4e080e7          	jalr	-434(ra) # 1c16 <list_del>
            list_add_tail(&entry->thrd->thread_list, args.run_queue);
    1dd0:	fc043783          	ld	a5,-64(s0)
    1dd4:	639c                	ld	a5,0(a5)
    1dd6:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffd618>
    1dda:	6498                	ld	a4,8(s1)
    1ddc:	85ba                	mv	a1,a4
    1dde:	853e                	mv	a0,a5
    1de0:	00000097          	auipc	ra,0x0
    1de4:	dda080e7          	jalr	-550(ra) # 1bba <list_add_tail>
    1de8:	a831                	j	1e04 <schedule_dm+0x94>
        }else{
            if (entry->release_time < closest_release_time){
    1dea:	fc043783          	ld	a5,-64(s0)
    1dee:	4f98                	lw	a4,24(a5)
    1df0:	fcc42783          	lw	a5,-52(s0)
    1df4:	2781                	sext.w	a5,a5
    1df6:	00f75763          	bge	a4,a5,1e04 <schedule_dm+0x94>
                closest_release_time = entry->release_time;
    1dfa:	fc043783          	ld	a5,-64(s0)
    1dfe:	4f9c                	lw	a5,24(a5)
    1e00:	fcf42623          	sw	a5,-52(s0)
    list_for_each_entry_safe(entry, tmp, args.release_queue, thread_list) {
    1e04:	fb843783          	ld	a5,-72(s0)
    1e08:	fcf43023          	sd	a5,-64(s0)
    1e0c:	fb843783          	ld	a5,-72(s0)
    1e10:	679c                	ld	a5,8(a5)
    1e12:	f4f43c23          	sd	a5,-168(s0)
    1e16:	f5843783          	ld	a5,-168(s0)
    1e1a:	17e1                	addi	a5,a5,-8
    1e1c:	faf43c23          	sd	a5,-72(s0)
    1e20:	fc043783          	ld	a5,-64(s0)
    1e24:	00878713          	addi	a4,a5,8
    1e28:	689c                	ld	a5,16(s1)
    1e2a:	f8f715e3          	bne	a4,a5,1db4 <schedule_dm+0x44>
    }

    // first check if there is any thread has missed its current deadline
    // TO DO

    struct thread *missed = __check_deadline_miss(args.run_queue, args.current_time);
    1e2e:	649c                	ld	a5,8(s1)
    1e30:	4098                	lw	a4,0(s1)
    1e32:	85ba                	mv	a1,a4
    1e34:	853e                	mv	a0,a5
    1e36:	00000097          	auipc	ra,0x0
    1e3a:	e54080e7          	jalr	-428(ra) # 1c8a <__check_deadline_miss>
    1e3e:	f8a43423          	sd	a0,-120(s0)
    if (missed != NULL) {
    1e42:	f8843783          	ld	a5,-120(s0)
    1e46:	c395                	beqz	a5,1e6a <schedule_dm+0xfa>
        // fprintf(1, "a");
        r.scheduled_thread_list_member = &missed->thread_list;
    1e48:	f8843783          	ld	a5,-120(s0)
    1e4c:	02878793          	addi	a5,a5,40
    1e50:	f2f43c23          	sd	a5,-200(s0)
        r.allocated_time = 0;
    1e54:	f4042023          	sw	zero,-192(s0)
        return r;
    1e58:	f3843783          	ld	a5,-200(s0)
    1e5c:	f4f43423          	sd	a5,-184(s0)
    1e60:	f4043783          	ld	a5,-192(s0)
    1e64:	f4f43823          	sd	a5,-176(s0)
    1e68:	aa7d                	j	2026 <schedule_dm+0x2b6>
    }

    // handle the case where run queue is empty
    // TO DO
    if (list_empty(args.run_queue)) {
    1e6a:	649c                	ld	a5,8(s1)
    1e6c:	853e                	mv	a0,a5
    1e6e:	00000097          	auipc	ra,0x0
    1e72:	df2080e7          	jalr	-526(ra) # 1c60 <list_empty>
    1e76:	87aa                	mv	a5,a0
    1e78:	c78d                	beqz	a5,1ea2 <schedule_dm+0x132>
        // fprintf(1, "b");
        r.scheduled_thread_list_member = args.run_queue;
    1e7a:	649c                	ld	a5,8(s1)
    1e7c:	f2f43c23          	sd	a5,-200(s0)
        r.allocated_time = closest_release_time - args.current_time;
    1e80:	409c                	lw	a5,0(s1)
    1e82:	fcc42703          	lw	a4,-52(s0)
    1e86:	40f707bb          	subw	a5,a4,a5
    1e8a:	2781                	sext.w	a5,a5
    1e8c:	f4f42023          	sw	a5,-192(s0)
        return r;
    1e90:	f3843783          	ld	a5,-200(s0)
    1e94:	f4f43423          	sd	a5,-184(s0)
    1e98:	f4043783          	ld	a5,-192(s0)
    1e9c:	f4f43823          	sd	a5,-176(s0)
    1ea0:	a259                	j	2026 <schedule_dm+0x2b6>
    }
    // 3. Find the real-time thread with the earliest deadline
    struct thread *selected = NULL;
    1ea2:	fa043823          	sd	zero,-80(s0)
    struct thread *th;
    list_for_each_entry(th, args.run_queue, thread_list) {
    1ea6:	649c                	ld	a5,8(s1)
    1ea8:	639c                	ld	a5,0(a5)
    1eaa:	f8f43023          	sd	a5,-128(s0)
    1eae:	f8043783          	ld	a5,-128(s0)
    1eb2:	fd878793          	addi	a5,a5,-40
    1eb6:	faf43423          	sd	a5,-88(s0)
    1eba:	a0a1                	j	1f02 <schedule_dm+0x192>
        if (!th->is_real_time)
    1ebc:	fa843783          	ld	a5,-88(s0)
    1ec0:	43bc                	lw	a5,64(a5)
    1ec2:	c785                	beqz	a5,1eea <schedule_dm+0x17a>
            continue;

        if (selected == NULL || __dm_thread_cmp(th, selected) < 0)
    1ec4:	fb043783          	ld	a5,-80(s0)
    1ec8:	cf81                	beqz	a5,1ee0 <schedule_dm+0x170>
    1eca:	fb043583          	ld	a1,-80(s0)
    1ece:	fa843503          	ld	a0,-88(s0)
    1ed2:	00000097          	auipc	ra,0x0
    1ed6:	e52080e7          	jalr	-430(ra) # 1d24 <__dm_thread_cmp>
    1eda:	87aa                	mv	a5,a0
    1edc:	0007d863          	bgez	a5,1eec <schedule_dm+0x17c>
            selected = th;
    1ee0:	fa843783          	ld	a5,-88(s0)
    1ee4:	faf43823          	sd	a5,-80(s0)
    1ee8:	a011                	j	1eec <schedule_dm+0x17c>
            continue;
    1eea:	0001                	nop
    list_for_each_entry(th, args.run_queue, thread_list) {
    1eec:	fa843783          	ld	a5,-88(s0)
    1ef0:	779c                	ld	a5,40(a5)
    1ef2:	f6f43023          	sd	a5,-160(s0)
    1ef6:	f6043783          	ld	a5,-160(s0)
    1efa:	fd878793          	addi	a5,a5,-40
    1efe:	faf43423          	sd	a5,-88(s0)
    1f02:	fa843783          	ld	a5,-88(s0)
    1f06:	02878713          	addi	a4,a5,40
    1f0a:	649c                	ld	a5,8(s1)
    1f0c:	faf718e3          	bne	a4,a5,1ebc <schedule_dm+0x14c>
    }

    // 4. If no real-time thread found
    if (selected == NULL) {
    1f10:	fb043783          	ld	a5,-80(s0)
    1f14:	ef99                	bnez	a5,1f32 <schedule_dm+0x1c2>
        // fprintf(1, "c");
        r.scheduled_thread_list_member = args.run_queue;;
    1f16:	649c                	ld	a5,8(s1)
    1f18:	f2f43c23          	sd	a5,-200(s0)
        r.allocated_time = 0;
    1f1c:	f4042023          	sw	zero,-192(s0)
        return r;
    1f20:	f3843783          	ld	a5,-200(s0)
    1f24:	f4f43423          	sd	a5,-184(s0)
    1f28:	f4043783          	ld	a5,-192(s0)
    1f2c:	f4f43823          	sd	a5,-176(s0)
    1f30:	a8dd                	j	2026 <schedule_dm+0x2b6>
    }

    // 5. Allocate time to the thread
    int next_release_time = __INT_MAX__;
    1f32:	800007b7          	lui	a5,0x80000
    1f36:	fff7c793          	not	a5,a5
    1f3a:	faf42223          	sw	a5,-92(s0)
    list_for_each_entry(entry, args.release_queue, thread_list) {
    1f3e:	689c                	ld	a5,16(s1)
    1f40:	639c                	ld	a5,0(a5)
    1f42:	f6f43c23          	sd	a5,-136(s0)
    1f46:	f7843783          	ld	a5,-136(s0)
    1f4a:	17e1                	addi	a5,a5,-8
    1f4c:	fcf43023          	sd	a5,-64(s0)
    1f50:	a805                	j	1f80 <schedule_dm+0x210>
        if (entry->release_time < next_release_time)
    1f52:	fc043783          	ld	a5,-64(s0)
    1f56:	4f98                	lw	a4,24(a5)
    1f58:	fa442783          	lw	a5,-92(s0)
    1f5c:	2781                	sext.w	a5,a5
    1f5e:	00f75763          	bge	a4,a5,1f6c <schedule_dm+0x1fc>
            next_release_time = entry->release_time;
    1f62:	fc043783          	ld	a5,-64(s0)
    1f66:	4f9c                	lw	a5,24(a5)
    1f68:	faf42223          	sw	a5,-92(s0)
    list_for_each_entry(entry, args.release_queue, thread_list) {
    1f6c:	fc043783          	ld	a5,-64(s0)
    1f70:	679c                	ld	a5,8(a5)
    1f72:	f6f43423          	sd	a5,-152(s0)
    1f76:	f6843783          	ld	a5,-152(s0)
    1f7a:	17e1                	addi	a5,a5,-8
    1f7c:	fcf43023          	sd	a5,-64(s0)
    1f80:	fc043783          	ld	a5,-64(s0)
    1f84:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffd5f8>
    1f88:	689c                	ld	a5,16(s1)
    1f8a:	fcf714e3          	bne	a4,a5,1f52 <schedule_dm+0x1e2>
    }

    int deadline_gap = selected->current_deadline - args.current_time;
    1f8e:	fb043783          	ld	a5,-80(s0)
    1f92:	4fb8                	lw	a4,88(a5)
    1f94:	409c                	lw	a5,0(s1)
    1f96:	40f707bb          	subw	a5,a4,a5
    1f9a:	f6f42a23          	sw	a5,-140(s0)
    int preempt_gap = next_release_time - args.current_time;
    1f9e:	409c                	lw	a5,0(s1)
    1fa0:	fa442703          	lw	a4,-92(s0)
    1fa4:	40f707bb          	subw	a5,a4,a5
    1fa8:	f6f42823          	sw	a5,-144(s0)

    int safe_alloc = selected->remaining_time;
    1fac:	fb043783          	ld	a5,-80(s0)
    1fb0:	4bfc                	lw	a5,84(a5)
    1fb2:	faf42023          	sw	a5,-96(s0)
    if (deadline_gap < safe_alloc) safe_alloc = deadline_gap;
    1fb6:	f7442703          	lw	a4,-140(s0)
    1fba:	fa042783          	lw	a5,-96(s0)
    1fbe:	2701                	sext.w	a4,a4
    1fc0:	2781                	sext.w	a5,a5
    1fc2:	00f75663          	bge	a4,a5,1fce <schedule_dm+0x25e>
    1fc6:	f7442783          	lw	a5,-140(s0)
    1fca:	faf42023          	sw	a5,-96(s0)
    if (preempt_gap < safe_alloc) safe_alloc = preempt_gap;
    1fce:	f7042703          	lw	a4,-144(s0)
    1fd2:	fa042783          	lw	a5,-96(s0)
    1fd6:	2701                	sext.w	a4,a4
    1fd8:	2781                	sext.w	a5,a5
    1fda:	00f75663          	bge	a4,a5,1fe6 <schedule_dm+0x276>
    1fde:	f7042783          	lw	a5,-144(s0)
    1fe2:	faf42023          	sw	a5,-96(s0)

    // Ensure safe_alloc is not negative
    if (safe_alloc <= 0) {
    1fe6:	fa042783          	lw	a5,-96(s0)
    1fea:	2781                	sext.w	a5,a5
    1fec:	00f04b63          	bgtz	a5,2002 <schedule_dm+0x292>
        r.scheduled_thread_list_member = &selected->thread_list;
    1ff0:	fb043783          	ld	a5,-80(s0)
    1ff4:	02878793          	addi	a5,a5,40
    1ff8:	f2f43c23          	sd	a5,-200(s0)
        r.allocated_time = 0;
    1ffc:	f4042023          	sw	zero,-192(s0)
    2000:	a819                	j	2016 <schedule_dm+0x2a6>
    } else {
        r.scheduled_thread_list_member = &selected->thread_list;
    2002:	fb043783          	ld	a5,-80(s0)
    2006:	02878793          	addi	a5,a5,40
    200a:	f2f43c23          	sd	a5,-200(s0)
        r.allocated_time = safe_alloc;
    200e:	fa042783          	lw	a5,-96(s0)
    2012:	f4f42023          	sw	a5,-192(s0)
    }
    // fprintf(1, "d");
    return r;
    2016:	f3843783          	ld	a5,-200(s0)
    201a:	f4f43423          	sd	a5,-184(s0)
    201e:	f4043783          	ld	a5,-192(s0)
    2022:	f4f43823          	sd	a5,-176(s0)
    2026:	4701                	li	a4,0
    2028:	f4843703          	ld	a4,-184(s0)
    202c:	4781                	li	a5,0
    202e:	f5043783          	ld	a5,-176(s0)
    2032:	893a                	mv	s2,a4
    2034:	89be                	mv	s3,a5
    2036:	874a                	mv	a4,s2
    2038:	87ce                	mv	a5,s3
}
    203a:	853a                	mv	a0,a4
    203c:	85be                	mv	a1,a5
    203e:	60ae                	ld	ra,200(sp)
    2040:	640e                	ld	s0,192(sp)
    2042:	74ea                	ld	s1,184(sp)
    2044:	794a                	ld	s2,176(sp)
    2046:	79aa                	ld	s3,168(sp)
    2048:	6169                	addi	sp,sp,208
    204a:	8082                	ret
