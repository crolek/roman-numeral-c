CC      = gcc
CFLAGS  = -g
RM      = rm -f

NAME = money
ARCHIVE = lib$(NAME).a


#AR = ar rc
AR = ar rcs
RANLIB = ranlib

SRC = src/money.c
OBJ = src/money.o
MONEYO = money.o

#---vars for testing
CHECK_LIBS  =    -Wl,--whole-archive -lcheck -Wl,--no-whole-archive
LIBS        =    -lm $(CHECK_LIBS)

TEST1        =    test_link
TEST1_SRC    =    tests/test_link.c

TEST1_FLAGS  =    $(CC_FLAGS) $(LD_FLAGS)
TEST1_LIBS   =    $(LIBS) -l$(NAME)

TESTS        =    $(TEST1)

#-----------targets
default: clean Money $(ARCHIVE) simpletest

all: Money testit

$(ARCHIVE): $(MONEYO)
	$(AR) $(ARCHIVE) $(MONEYO)
#	$(AR) $(ARCHIVE) $^
	$(RANLIB) $(ARCHIVE)


Money: src/money.c
	$(CC) -c $(SRC) -o $(MONEYO)

clean veryclean:
	$(RM) Hello
	$(RM) testit
	$(RM) libmoney.a
	$(RM) $(MONEYO)
	$(RM) $(OBJ)
	$(RM) tests/test_link.gcno

simpletest: $(TEST1_SRC)
	ls -l
	$(CC) tests/test_link.c -L. -lmoney -o testit
#	$(CC) tests/test_link.c libmoney.a -o testit
#	$(CC) -L. -lmoney -Wl,-static -o testit tests/test_link.c

testit: $(TEST1_SRC)
	$(CC) $(TEST1_FLAGS) -o $@ $^ $(TEST1_LIBS)


Hello: Hello.c
	$(CC) $(CFLAGS) -o Hello Hello.c
