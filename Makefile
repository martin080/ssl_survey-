all: ssl_survey

CC = gcc -g -Wall -std=c99 
LIBS = `pkg-config --cflags --libs  openssl libuv`  
# TRUST_STORE = /etc/ssl/certs/ca-certificates.crt

SRC = $(wildcard *.c)
OBJ = $(patsubst %.c, %.o, $(SRC))
OUTPUT = ssl_survey
TRUST_DEF =

ifdef TRUST_STORE
	TRUST_DEF=-DTRUST_STORE=\"$(TRUST_STORE)\"
endif 

ssl_survey: $(OBJ)
	@$(CC) $^ -o $(OUTPUT) $(LIBS)
 
scan.o: scan.c 
	@$(CC)  $(TRUST_DEF) -c scan.c

%.o: %.c
	@$(CC) -c $< -o $@  

clean:
	$(RM) $(OBJ) 
