#define NO_ERR						 0
#define EXCEPTION_ITEM_NOT_FOUND 	 -1
#define EXCEPTION_INSUFFICIENT_FUNDS -2
#define EXCEPTION_NOT_ENOUGH_GOODS	 -3

char* Soom_AutonomousStringCopy (const char* string)
{
    if (string == NULL)
        return NULL;
    
    char* res = (char*)malloc(strlen(string) + 1);
    strcpy(res, string);
    return res;
}
