#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <fcntl.h>


#include "integration.h"
#include "../driver/driver.h"

/***
 * Tentando fazer uma função generica para evitar a duplicidade de código
 */
int execute_ioctl( long unsigned int func_name, void* param){
    int fp, ret; 
    fp = open("/dev/damas", O_RDWR);
    if (fp < 0)
    {
        perror("Nao foi possivel acessar\n");
    }
    if(param == NULL){
        ret = ioctl(fp, func_name);
    }
    else{
        ret = ioctl(fp, func_name, param);
    }

    if (ret < 0)
    {
        printf("Erro ao setar o delay");
    }
    close(fp);
    return ret;
};

int join_game( void ){
    int ret, fp;
    fp = open("/dev/damas", O_RDWR);
    if( fp < 0){
        perror("Não foi possivel Acessar\n");
    }
    ret = ioctl(fp, IOCTL_JOIN_GAME);
    close(fp);
    return ret;
}


int get_winner(void){
    int ret, fp;
    fp = open("/dev/damas", O_RDWR);
    if( fp < 0){
        perror("Não foi possivel Acessar\n");
    }
    ret = ioctl(fp, IOCTL_GET_WINNER);
    close(fp);
    return ret;
}

int set_winner(int winner){
    int ret, fp;
    fp = open("/dev/damas", O_RDWR);
    if( fp < 0){
        perror("Não foi possivel Acessar\n");
    }
    ret = ioctl(fp, IOCTL_SET_WINNER, winner);
    close(fp);
    return ret;
}

int get_current_turn(void){
    int ret, fp;
    fp = open("/dev/damas", O_RDWR);
    if( fp < 0){
        perror("Não foi possivel Acessar\n");
    }
    ret = ioctl(fp, IOCTL_READ_CURRENT_TURN);
    close(fp);
    return ret;
}

int get_player_count(void){
    int ret, fp;
    fp = open("/dev/damas", O_RDWR);
    if( fp < 0){
        perror("Não foi possivel Acessar\n");
    }
    ret = ioctl(fp, IOCTL_READ_TOTAL_PLAYER_COUNT);
    close(fp);
    return ret;
}

int get_plays_count(void){
    int ret, fp;
    fp = open("/dev/damas", O_RDWR);
    if( fp < 0){
        perror("Não foi possivel Acessar\n");
    }
    ret = ioctl(fp, IOCTL_PLAYS_COUNT);
    close(fp);
    return ret;
}

int change_turn(void){
    int ret, fp;
    fp = open("/dev/damas", O_RDWR);
    if( fp < 0){
        perror("Não foi possivel Acessar\n");
    }
    ret = ioctl(fp, IOCTL_CHANGE_TURN);
    close(fp);
    return ret;
}
int end_game ( void ){
    int ret, fp;
    fp = open("/dev/damas", O_RDWR);
    if( fp < 0){
        perror("Não foi possivel Acessar\n");
    }
    ret = ioctl(fp, IOCTL_END_GAME);
    if( ret > 0 ){
    }
    close(fp);
    return ret;
}
