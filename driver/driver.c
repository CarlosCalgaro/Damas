#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/proc_fs.h>
#include <linux/uaccess.h>

#include "driver.h"

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Carlos Alberto Calgaro Filho");
MODULE_DESCRIPTION("Jogo de Damas");

#define DEVICE 60
#define DEVICE_NAME "damas"
#define BUF_MSG 4000

int init_device(void);
void cleanup_device(void);
static int device_open(struct inode *inode, struct file *file);
static int device_release(struct inode *inode, struct file *file);
static ssize_t device_read(struct file *file, char __user *buffer, size_t length, loff_t *offset);
static ssize_t device_write(struct file *file, const char __user *buffer, size_t length, loff_t *offset);
void change_turn(void);

/*** 
 * Damas
 * 
 */
long device_ioctl(struct file *file, unsigned int ioctl_num, unsigned long ioctl_param);

module_init(init_device);
module_exit(cleanup_device)

static int aberto = 0;
static char mensagem[BUF_MSG];
static char *ptr;

static int playerCount = 0;
static int currentTurn = 1;
static int playsCount = 0;
static int winner = 0;

struct file_operations fops = {
	.read = device_read,
	.write = device_write,
	.open = device_open,
	.release = device_release,
	.unlocked_ioctl = device_ioctl};

long device_ioctl(struct file *file, unsigned int ioctl_num, unsigned long ioctl_param)
{
	int length;
	char *temp = NULL;
	switch (ioctl_num)
	{
	case IOCTL_SET_SPEAKER:
		temp = (char *)ioctl_param;
		length = 0;
		printk("Accessing Driver !!!!");
		device_write(file, (char *)ioctl_param, length, 0);
		break;
	case IOCTL_JOIN_GAME:
		if( playerCount >=2 ){
			printk("O jogo ja está cheio! Por favor feche ele rodando IOCTL_END_GAME");
			return -1;
		}
		playerCount++;
		printk("Um jogador entrou no jogo! Atribuido como %d", playerCount);
		return playerCount;
	case IOCTL_END_GAME:
		printk("Jogo finalizado!\n");
		currentTurn = 1;
		playerCount = 0;
		playsCount = 0;
		winner = 0;
		break;
	case IOCTL_CHANGE_TURN:
		change_turn();
		break;
	case IOCTL_READ_CURRENT_TURN:
		return currentTurn;
	case IOCTL_GET_WINNER:
		printk("Buscando novo vencedor: %d", winner);
		return winner;
	case IOCTL_SET_WINNER:
		winner = (int)ioctl_param;
		printk("Temos um novo vencedor: %d", winner);
		break;
	case IOCTL_READ_TOTAL_PLAYER_COUNT:
		return playerCount;
	case IOCTL_PLAYS_COUNT:
		return playsCount;
		break;
	default:
		printk("Essa operacao nao e permitida.\n");
		return -1;
	}
	return 0;
}

void change_turn(){
	playsCount++;
	if(currentTurn == 2){
		currentTurn = 1;
	}else{
		currentTurn = 2;
	}
}

int init_device()
{

	int ret;

	ret = register_chrdev(DEVICE, DEVICE_NAME, &fops);

	if (ret < 0)
	{
		printk("Erro ao carregar o dispositivo %d\n.", DEVICE);
		return ret;
	}

	printk("O dispositivo %d foi carregado.\n", DEVICE);

	return 0;
}

void cleanup_device()
{

	unregister_chrdev(DEVICE, DEVICE_NAME);
	printk("O dispositivo %d foi descarregado.\n", DEVICE);
}

static int device_open(struct inode *inode, struct file *file)
{

	if (aberto)
	{
		return -EBUSY;
	}
	aberto++;
	ptr = mensagem;

	try_module_get(THIS_MODULE);
	return 0;
}

static int device_release(struct inode *inode, struct file *file)
{

	aberto--;

	module_put(THIS_MODULE);
	return 0;
}

static ssize_t device_read(struct file *file, char __user *buffer, size_t length, loff_t *offset)
{
	int i, bytes_read = 0;
	if (*ptr == 0)
	{
		return 0;
	}
	for (i = 0; *ptr; i++)
	{
		put_user(*(ptr++), buffer++);
		bytes_read++;
	}
	printk("Leu %d bytes correspondendo a mensagem: %s", bytes_read, mensagem);
	return bytes_read;
}

static ssize_t device_write(struct file *file, const char __user *buffer, size_t length, loff_t *offset)
{
	int i;
	
	for( i = 0; i < BUF_MSG; i++){
		mensagem[i]= '\0';
	}
	for (i = 0; i < length; i++)
	{
		get_user(mensagem[i], buffer + i);
	}
	ptr = mensagem;
	printk("Escreveu jogada");
	return i;
}
