#ifndef _DAMAS_H_
#define _DAMAS_H_
#define IOCTL_SET_SPEAKER _IOW('s', 1, int)
#define IOCTL_JOIN_GAME _IOR('s', 2, int)
#define IOCTL_END_GAME _IO('s', 3)
#define IOCTL_READ_CURRENT_TURN _IOR('s', 4, int)
#define IOCTL_READ_TOTAL_PLAYER_COUNT _IOR('s', 5, int)
#define IOCTL_CHANGE_TURN _IO('s', 6)
#define IOCTL_PLAYS_COUNT _IOR('s', 7, int)
#define IOCTL_SET_WINNER _IOW('s', 8, int)
#define IOCTL_GET_WINNER _IOR('s', 9, int)
#endif

