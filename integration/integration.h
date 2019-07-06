
#ifndef _DAMAS_INTEGRATION_H_
#define _DAMAS_INTEGRATION_
    int execute_ioctl( long unsigned int func_name, void* param);
    int join_game( void );
    int end_game( void );
    int get_current_turn(void);
    int get_player_count(void);
    int change_turn(void);
    int get_plays_count(void);
    int get_winner(void);
    int set_winner(int winner);
#endif