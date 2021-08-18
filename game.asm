########################################################
# CSCB58 Summer 2021 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Rubaiz Momin, 1006903479, mominrub || Manas Khandelwal, 1006824153, khande50
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8 
# - Unit height in pixels: 8 
# - Display width in pixels: 256 
# - Display height in pixels: 256 
#
# Which milestones have been reached in this submission?
# - Milestone 1/2/3 (choose the one the applies)
#   Milestone 3
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features) 
#Increase in difficulty as game progresses.Difficulty can achieved by making things faster.
#Added â€œpick-upsâ€? that the ship can pick up . These grant benefits such as full health and  repair the ship, etc.
#Enemy ships â€“some obstacles look different and move in â€œunnaturalâ€?, difficult, or surprising patterns.
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it! #

# Are you OK with us sharing the video with people outside course staff?
# - yes / no / yes, and please share this project github link as well! #
# yes
# Any additional information that the TA needs to know:
# - (write here, if any)
# #####################################################################
.data 
	
	BASE_ADD: .word 0x10008000
	ENEMY_ADD: .word 0x10008000
	GREEN: .word 0x0000ff00
	RED: .word 0x00ff0000
	SP_START_ADD: .word 0x10008600
	OBSTACLE_TEMP_ADD: .word 0x10008500
	BLACK: .word 0x00000000
	COLLISION_COL: .word 0x00ffff00
	END_ADD: .word 0x10008000
	COLL_COUNT: .word 0
	COLL_COUNT_MAX: .word 5
	WHITE_END_COLOR: .word 0x00ffffff
	BLUE_END_COLOR: .word 0x000000ff
	WHITE_HEALTH_COLOR: .word 0x00ffffff
	GREEN_HEALTH_COLOR: .word 0x0000ff00
	HEALTH_COUNT: .word 0
	WHITE: .word 0x00ffffff
	BLUE_SL_COLOUR: .word 0x000000ff
	SLEEP_TIME: .word 300
	OBJ_1_LAST: .word 0x10008000
	OBJ_2_LAST: .word 0x10008000
	OBJ_3_LAST: .word 0x10008000
	OBJ_4_LAST: .word 0x10008000
	BOT_LEFT: .word 0x10012092
	BR: .word 0x10008ffc
	TL: .word 0x10008e54
	SPELL_ADD: .word 0x10008000
	COUNTER: .word 0x0
	


.globl main1

.text

stack:
	#Stack starts
	
	addi $sp, $sp, -156
	
	lw $t0, GREEN      #green
	sw $t0, 0($sp)
	lw $t0, RED        #red
	sw $t0, 4($sp)
	lw $t0, BASE_ADD          #baseaddress
	sw $t0, 8($sp)
	lw $t0, SP_START_ADD     #start pos of ship
	sw $t0, 12($sp)
	lw $t0, OBSTACLE_TEMP_ADD      #temporary start pos for obstacle
	sw $t0, 16($sp)
	lw $t0, BLACK                #  black
	sw $t0, 20($sp)
	lw $t0, BASE_ADD    # obstacle 1 current pos
	sw $t0, 24($sp)
	lw $t0, BASE_ADD    # obstacle 2 current pos
	sw $t0, 28($sp)
	lw $t0, BASE_ADD    # obstacle 3 current pos
	sw $t0, 32($sp)
	lw $t0, SP_START_ADD  # ship current pos
	sw $t0, 36($sp)
	lw $t0, BASE_ADD    # obstacle 4 current pos
	sw $t0, 40($sp)
	lw $t0, BASE_ADD   # obstacle 1 start pos
	sw $t0, 44($sp)
	lw $t0, BASE_ADD   # obstacle 2 start pos
	sw $t0, 48($sp)
	lw $t0, BASE_ADD  # obstacle 3 start pos
	sw $t0, 52($sp)
	lw $t0, BASE_ADD  # obstacle 4 start pos
	sw $t0, 56($sp)
	lw $t0, COLLISION_COL  # yellow
	sw $t0, 60($sp)
	lw $t0 END_ADD            #temporary placeholder for bottom right
	sw $t0, 64($sp)
	lw $t0 COLL_COUNT        #collision count keeper
	sw $t0, 68($sp)
	lw $t0 COLL_COUNT_MAX       #max collision allowed
	sw $t0, 72($sp)
	lw $t0 COLL_COUNT  # Current Ccollision count
	sw $t0, 76($sp)
	lw $t0 WHITE_END_COLOR	# white
	sw $t0, 80($sp)
	lw $t0 BLUE_END_COLOR  # blue
	sw $t0, 84($sp)
	lw $t0 WHITE_HEALTH_COLOR  # white health colour
	sw $t0, 88($sp)
	lw $t0 GREEN_HEALTH_COLOR  # health green colour(no use)
	sw $t0, 92($sp)
	lw $t0, HEALTH_COUNT      # tracks health
	sw $t0, 96($sp)		
	lw $t0, WHITE              # white
	sw $t0, 100($sp)	
	lw $t0, ENEMY_ADD         # enemy add
	sw $t0, 104($sp)	
	lw $t0, BASE_ADD          #immortality cur add
	sw $t0, 108($sp)	
	lw $t0, BLUE_SL_COLOUR  # blue 
	sw $t0, 112($sp)	
	lw $t0, SPELL_ADD        # elixir curr position
	sw $t0, 116($sp)	
	lw $t0, HEALTH_COUNT      # keeps track of health
	sw $t0, 120($sp)	
	lw $t0, SLEEP_TIME       # time to sleep
	sw $t0, 124($sp)	
	lw $t0, OBJ_1_LAST       # object 1 last position it can reach
	sw $t0, 128($sp)	
	lw $t0, OBJ_2_LAST        # object 2 last position it can reach
	sw $t0, 132($sp)	
	lw $t0, OBJ_3_LAST        # object 3 last position it can reach
	sw $t0, 136($sp)	
	lw $t0, OBJ_4_LAST      # object 4 last position it can reach
	sw $t0, 140($sp)	
	lw $t0, BOT_LEFT        # bottom left health
	sw $t0, 144($sp)	
	lw $t0, BR               # bottom right health
	sw $t0, 148($sp)	
	lw $t0, TL                  # top left health
	sw $t0, 152($sp)	 
	lw $t0, COUNTER         #checks which obstacle touches
	sw $t0, 156($sp)
	
	
	
	
	
	
	
	
	
	
mainsetup:



	# this is for setting up of game at the begining

	jal shipsetup
	jal obs1setup
	jal obs2setup
	jal obs3setup
	jal obs4setup
	jal health_set
	jal enemy_set
	jal booster_set
	jal elixir_setup

	#SLEEP
	
	li $v0, 32
	li $a0, 450
	syscall
	j main1
	
		
booster_set:

#This is the green dot which provide the user with full health and this function setup the starting position for the power up

	lw $t7, 8($sp)
	
	addi $t7, $t7, 124
	

	li $v0, 42
	li $a0, 0
	li $a1, 27
	syscall
	
	li $t0, 128
	
	mult $a0 $t0
	mflo $t0
	
	lw $s1, 16($sp)
	add $t0, $t0, $t7
	
	sw $t0, 108($sp)
	
	lw $t1, 0($sp) 
	
	sw $t1, 0($t0)

	
	jr $ra
	
	
elixir_setup:

#this will choose a random number to set its starting position. THis is the blue dot which provides one health increment
	lw $t7, 8($sp)
	
	addi $t7, $t7, 108
	

	li $v0, 42
	li $a0, 0
	li $a1, 27
	syscall
	
	li $t0, 128
	
	mult $a0 $t0
	mflo $t0
	
	lw $s1, 16($sp)
	add $t0, $t0, $t7
	
	sw $t0, 116($sp)
	
	lw $t1, 0($sp) 
	
	sw $t1, 0($t0)

	
	jr $ra


health_set:
	lw $t6, 100($sp)
	lw $t2, 152($sp)
	sw $t6, 0($t2)
	sw $t6, 128($t2)
	sw $t6, 256($t2)
	sw $t6, 384($t2)
	
	sw $t6, 8($t2)   #0
	sw $t6, 12($t2)
	sw $t6, 16($t2)
	sw $t6, 20($t2)
	sw $t6, 148($t2)   
	sw $t6, 276($t2)
	sw $t6, 404($t2)
	sw $t6, 400($t2)
	sw $t6, 396($t2)
	sw $t6, 392($t2)  #up
	sw $t6, 136($t2)
	sw $t6, 264($t2)

	sw $t6, 28($t2)   #another 0
	sw $t6, 32($t2)
	sw $t6, 36($t2)
	sw $t6, 40($t2)
	sw $t6, 168($t2)   
	sw $t6, 296($t2)
	sw $t6, 424($t2)
	sw $t6, 420($t2)
	sw $t6, 416($t2)
	sw $t6, 412($t2)  #up
	sw $t6, 156($t2)
	sw $t6, 284($t2)
	
	jr $ra
	
shipsetup:

	# Setting up the spaceship 
	
	lw $t2, 8($sp)
	addi $t0, $t2, 2056

	lw $t1 0($sp)
	
	sw $t0, 36($sp)
	
	sw $t1 0($t0)
	sw $t1 128($t0)
	sw $t1 256($t0)
	sw $t1 124($t0)
	sw $t1 120($t0)
	sw $t1 248($t0)
	sw $t1 -8($t0)
	sw $t1 132($t0)
	
	jr $ra
	
enemy_set:

#THis function helps in setting up the enemy from above at a random position 
	
	lw $t7, 8($sp)

	li $v0, 42
	li $a0, 0
	li $a1, 29
	syscall
	
	li $t0, 4
	
	mult $a0 $t0
	mflo $t0
	
	lw $s1, 16($sp)
	
	add $t0, $t0, $t7
	
	sw $t0, 104($sp)
	
	lw $t1, 100($sp) 
	
	sw $t1, 0($t0)

	jr $ra

obs1setup:


	lw $t1, 8($sp)            # loading the base address to t1
	addi $t1, $t1, 124        # adding 124 which will make t1 point to the top right address
	li $v0, 42                # 42 calls for random generator with a max limit
	li $a0, 0                 # setting the lower limit for random generator to 0
	li $a1, 8                 # setting the upper limit for random generator to 7 (one-third of the screen)
	syscall
	
	li $t3, 128               # storing the constant 128 in t3 for offset
	mult $a0, $t3             # multiplying the random number with 128
	mflo $t3                  # moving the output to t3
	add $t3, $t3, $t1         # adding the offest with the top right address to go the particular address of the object 1
	lw $t2, 4($sp)            # loading the colour  red in t2
	sw $t3, 24($sp)            # storing the object moving position to 8($sp) which is OBJ1_MVP
	sw $t2, 0($t3)            # colouring the first block of object 1
	sw $t2, 128($t3)          # colouring the second block of the object 1
	sw $t2, 256($t3)          # colouring the second block of the object 1	
	addi $t3, $t3, -124       # getting the left most address by subtracting 124
	sw $t3, 128($sp)           # storing the last position the object 2 can go in END_OBJ2 
	jr $ra
	
obs2setup:



	lw $t1, 8($sp)            # loading the base address to t1
	addi $t1, $t1, 1404       # adding 124 which will make t1 point to the top right address
	li $v0, 42                # 42 calls for random generator with a max limit
	li $a0, 0                 # setting the lower limit for random generator to 10
	li $a1, 8                 # setting the upper limit for random generator to 17 (one-third of the screen)
	syscall
	
	li $t3, 128                # storing the constant 128 in t3 for offset
	mult $a0, $t3             # multiplying the random number with 128
	mflo $t3                  # moving the output to t3
	add $t3, $t3, $t1         # adding the offest with the top right address to go the particular address of the object 2
	lw $t2, 4($sp)            # loading the colour  red in t2
	sw $t3, 28($sp)	           # storing the object moving position to 12($sp) which is OBJ2_MVP
	sw $t2, 0($t3)            # colouring the first block of object 2
	sw $t2, 128($t3)          # colouring the second block of the object 2
	sw $t2, 256($t3)          # colouring the second block of the object 2
	addi $t3, $t3, -124       # getting the left most address by subtracting 124
	sw $t3, 132($sp)           # storing the last position the object 2 can go in END_OBJ2 
	jr $ra    
	
obs3setup:


	lw $t1, 8($sp)            # loading the base address to t1
	addi $t1, $t1, 2684       # adding 124 which will make t1 point to the top right address
	li $v0, 42                # 42 calls for random generator with a max limit
	li $a0, 0                 # setting the lower limit for random generator to 20
	li $a1, 6                 # setting the upper limit for random generator to 29
	syscall
	
	
	li $t3,128      	   # storing the constant 128 in t3 for offset
	mult $a0, $t3             # multiplying the random number with 128
	mflo $t3                  # moving the output to t3
	add $t3, $t3, $t1         # adding the offest with the top right address to go the particular address of the object 3
	lw $t2, 4($sp)            # loading the colour  red in t2
	sw $t3, 32($sp)	           # storing the object moving position to 12($sp) which is OBJ3_MVP
	sw $t2, 0($t3)            # colouring the first block of object 3
	sw $t2, 128($t3)          # colouring the second block of the object 3
	sw $t2, 256($t3)          # colouring the second block of the object 3
	addi $t3, $t3, -124       # getting the left most address by subtracting 124
	sw $t3, 136($sp)           # storing the last position the object 2 can go in END_OBJ2 
	jr $ra                    #jumping to ht enext line of the calling function
	
obs4setup:


	lw $t1, 8($sp)            # loading the base address to t1
	addi $t1, $t1, 2684       # adding 124 which will make t1 point to the top right address
	li $v0, 42                # 42 calls for random generator with a max limit
	li $a0, 0                 # setting the lower limit for random generator to 20
	li $a1, 6                # setting the upper limit for random generator to 29
	syscall
	
	
	li $t3,128      	   # storing the constant 128 in t3 for offset
	mult $a0, $t3             # multiplying the random number with 128
	mflo $t3                  # moving the output to t3
	add $t3, $t3, $t1         # adding the offest with the top right address to go the particular address of the object 3
	lw $t2, 4($sp)            # loading the colour  red in t2
	sw $t3, 40($sp)	           # storing the object moving position to 12($sp) which is OBJ3_MVP
	sw $t2, 0($t3)            # colouring the first block of object 3
	sw $t2, 128($t3)          # colouring the second block of the object 3
	sw $t2, 256($t3)          # colouring the second block of the object 3
	addi $t3, $t3, -124       # getting the left most address by subtracting 124
	sw $t3, 140($sp)           # storing the last position the object 2 can go in END_OBJ2 
	jr $ra                    #jumping to ht enext line of the calling function
	
	
	
	

main1:

#recursive function to let the game move ina loop
	
	jal obstacle1
	jal obstaclecollision1
	jal obstacle2
	jal obstaclecollision2
	jal obstacle2
	jal obstaclecollision2
	jal obstacle2
	jal obstaclecollision2
	jal obstacle3
	jal obstaclecollision3
	jal obstacle4
	jal obstaclecollision4
	jal obstacle4
	jal obstaclecollision4
	jal enemy_movt
	jal enemy_coll
	jal immortality_movt
	jal immortal_coll
	jal elixir_movt
	jal elixir_coll
	jal key_checker

	
	lw $t0, 124($sp)       
	li $t1, 75
	
	bge $t0, $t1, sleep
	#Sleeps
	li $v0, 32
	li $a0, 75
	syscall
	
	j main1
	
sleep:
#Difficuly increment. It decreases the time to sleep between movements
	
	lw $t1, 124($sp)
	
	li $v0, 32
	move $a0, $t1
	syscall
	
	j main1

	
key_checker:
#checks whether a key is pressed or not
	
	li $t0, 0xffff0000
	lw $t1, 0($t0)
	beq $t1, 1, press_checker
	jr $ra
	
press_checker:


	lw $t1, 0($sp)	 #Spaceship Color
	lw $t2, 36($sp)  # Current Position
	
	
	lw $t5, 20($sp)  # Black Color
	
	li $t9, 0xffff0000     #storing the keyboard IO address in t9
	lw $t8, 0($t9)         # t8 to t9
	beq $t8, 1, which_key   # going to keycheck if keyboard press is detected
	jr $ra
	       
which_key:lw $t7, 4($t9)             # offset to 4 of t9 to get the value of the key pressed
	beq $t7, 0x70, respond_to_p   #checking if p(ACSCII=112) is pressed or not
        beq $t7, 0x61, respond_to_a	
        beq $t7, 0x64, respond_to_d
        beq $t7, 0x73, respond_to_s
        beq $t7, 0x77, respond_to_w
        jr $ra
key_exit:

	#exiting after doing the movement

	jr $ra

after_collision:


	# This is the dummy object which will be used when a key is pressed and we need to swap positions
	# of blocks so as to show it moving
	lw $t5, 20($sp)
	sw $t5, 0($t2)
	sw $t5, 128($t2)
	sw $t5, 256($t2)
	sw $t5, 124($t2)
	sw $t5, 120($t2)
	sw $t5, 132($t2)
	sw $t5, -8($t2)
	sw $t5, 248($t2)
        
        
	sw $t3, 36($sp)
        lw $t1, 0($sp)
	sw $t1, 0($t3)
	sw $t1, 128($t3)
	sw $t1, 256($t3)
        sw $t1, 124($t3)
	sw $t1, 120($t3)
	sw $t1, 132($t3)
	sw $t1, -8($t3)
	sw $t1, 248($t3)
	
	jr $ra
	
respond_to_p:


       lw $t0, 8($sp)            #storing the base address
       lw $t1, 144($sp)           #storing the maximum address which is the bottom right corner of bitmap
       lw $t2, 20($sp)          # storing the black colour in t2
       sw $zero, 60($sp) 
black_screen:

	bge $t0, $t1, end_p   #checking if t0 == t1
	sw $t2, 0($t0)           #colouring the current pixel black
	addi $t0, $t0, 4         #adding t0 = t0 + 4
	j black_screen
		
respond_to_a:
       
       lw $t3, 8($sp)      #base address
       lw $t0, 36($sp)     #ship pos
       li $t5, 128         #loading constant 128
       #checking if the left part is touhing the left boundary of the bitmap
       addi $t9, $t0, -8
       beq $t9, $t3, key_exit	
       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       	
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	
	addi $t3, $t0, -4
	move $s1 $ra
	jal after_collision
	move $ra, $s1
	li $v0, 32
	li $a0, 20
	syscall 
	j key_exit
	
respond_to_d:


	       
       lw $t3, 8($sp)      #base address
       lw $t0, 36($sp)     #ship pos
       li $t5, 128         #loading constant 128
       addi $t3, $t3, 124   #going to right
       addi $t9, $t0, 132
       #checking if the ship is touching the right boundary
       beq $t9, $t3, key_exit	
       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       	
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	       
	addi $t3, $t3, 128
	beq $t9, $t3, key_exit	
	
	addi $t3, $t0, 4
	move $s1 $ra
	jal after_collision
	move $ra, $s1
	li $v0, 32
	li $a0, 20
	syscall 
	j key_exit
	
respond_to_w:
	
	
       lw $t3, 8($sp)      #base address
       lw $t0, 36($sp)     #ship pos
       li $t5, 128         #loading constant 128
       #checking if the left part is touhing the upper boundary of the bitmap

	beq $t0, $t3, key_exit	
       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       	
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	
	addi $t3, $t0, -128
	lw $t4, 0($t3)
	move $s1 $ra
	jal after_collision
	move $ra $s1
	li $v0, 32
	li $a0, 20
	syscall 
	j key_exit
	
respond_to_s:


       lw $t3, 8($sp)      #base address
       lw $t0, 36($sp)     #ship pos
       li $t5, 128         #loading constant 128
       addi $t3, $t3, 3200

       addi $t6, $t0, 256
	
       #checking if the bottom part is touhing the left boundary of the bitmap

	beq $t0, $t3, key_exit	
       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       	
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	       
	addi $t3, $t3, 4
	beq $t0, $t3, key_exit	
	
	addi $t3, $t0, 128
	lw $t4, 0($t3)
	move $s1 $ra
	jal after_collision
	move $ra $s1
	li $v0, 32
	li $a0, 20
	syscall 
	j key_exit
	

enemy_remove:


#this function is called only when the enemy ship touches the bottom limit and then it calls enemy_set to make a new enemy
	lw $t5, 104($sp)
	lw $t6, 20($sp)
	
	
	sw $t6, 0($t5)

	
	j enemy_set
	
	
	
	

enemy_movt:

	#this makes the enemy ship move down
	lw $t2, 104($sp)
	
	lw $t7, 8($sp)

	addi $t7, $t7, 3456
# this checks whether the enemy ship touches the bottom part and if yes, it calls enemymove
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
	addi $t7, $t7, 4
	beq $t2, $t7, enemy_remove	
#updating the new enemy address
	lw $t1, 100($sp)   
	addi $t4, $t2, 128
	lw $t3, 20($sp)    
	
	sw $t4, 104($sp)

	sw $t1, 0($t4)
	
	sw $t3, 0($t2)
	
	jr $ra

health_remove:

	#when immortality reaches the left end similarly to the obstacle this will call the booster set to create another one
	lw $t5, 108($sp)
	lw $t6, 20($sp)
	
	
	sw $t6, 0($t5)

	
	j booster_set

health_touch_remove:

#a function to re draw the ship area which touched the power up
	
	lw $t5, 108($sp)
	lw $t6, 0($sp)
        sw $t6, 0($t5)
	
	j booster_set	

	
immortality_movt:

	# This function will keep moving health towards left until it reaches left end

	lw $t2, 108($sp)
	
	lw $t7, 8($sp)
		
	# If health maxer reaches left end of screen a new one will appear 
	
	beq $t2, $t7, health_remove	#1
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#2
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#3
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#4
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#5
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#6
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#7
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#8
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#9
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#10
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#11
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#12
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#13
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#14
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#15
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#16
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#17
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#18
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#19
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#20
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#21
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#22
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#23
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#24
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#25
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#26
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#27
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#28
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#29
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#30
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#31
	addi $t7, $t7, 128
	beq $t2, $t7, health_remove	#32
	
	
	lw $t1, 0($sp)   #  green
	addi $t4, $t2, -4
	lw $t3, 20($sp)  # black
	
	sw $t4, 108($sp)

	sw $t1, 0($t4)

	
	sw $t3, 0($t2)

	
	
	jr $ra
	
elixir_coll:


	lw $t0, 36($sp)
	addi $t1, $t0, 128
	addi $t2, $t0, 256
	addi $t3, $t0, 124
	addi $t4, $t0, 120
	addi $t5, $t0, 248
	addi $t6, $t0, -8
	addi $t7, $t0, 132
	
	lw $s1, 116($sp)
#this checks whether the elixir collides or not
	beq $t0, $s1, full_health_detect
	beq $t1, $s1, full_health_detect
	beq $t3, $s1, full_health_detect
	beq $t4, $s1, full_health_detect
	beq $t5, $s1, full_health_detect
	beq $t6, $s1, full_health_detect
	beq $t7, $s1, full_health_detect
	beq $t2, $s1, full_health_detect
	
	jr $ra
	
full_health_detect:

	#if health is full then it ignores otherwise increases health by 1 counter
	lw $t3, 76($sp)
	bgtz $t3, updatehealth
go_new: 	
	j elixir_remove
	
updatehealth:

	#this increases health by 1 when ship collides with elixir
	

	addi $t3, $t3, -1
	sw $t3, 76($sp)   
	
	lw, $t4, 8($sp)   
	
	beq $t3, 0, change_hundred
	beq $t3, 1, change_eighty
	beq $t3, 2, change_sixty
	beq $t3, 3, change_forty	
	
change_hundred:	
	lw $t5, 152($sp)
	lw $t6, 148($sp)
	lw $t3, 20($sp)
lo1:	bgt $t5, $t6, go1
	sw $t3, 0($t5)
	addi $t5, $t5, 4
	j lo1
go1:	lw $t2, 152($sp)
	lw $t6, 100($sp)
	sw $t6, 0($t2)   #1
	sw $t6, 128($t2)
	sw $t6, 256($t2)
	sw $t6, 384($t2)
	
	sw $t6, 8($t2)   #0
	sw $t6, 12($t2)
	sw $t6, 16($t2)
	sw $t6, 20($t2)
	sw $t6, 148($t2)   
	sw $t6, 276($t2)
	sw $t6, 404($t2)
	sw $t6, 400($t2)
	sw $t6, 396($t2)
	sw $t6, 392($t2)  #up
	sw $t6, 136($t2)
	sw $t6, 264($t2)

	sw $t6, 28($t2)   #another 0
	sw $t6, 32($t2)
	sw $t6, 36($t2)
	sw $t6, 40($t2)
	sw $t6, 168($t2)   
	sw $t6, 296($t2)
	sw $t6, 424($t2)
	sw $t6, 420($t2)
	sw $t6, 416($t2)
	sw $t6, 412($t2)  #up
	sw $t6, 156($t2)
	sw $t6, 284($t2)
	j elixir_remove

change_eighty:	
	lw $t5, 152($sp)
	lw $t6, 148($sp)
	lw $t3, 20($sp)
lo2:	bge $t5, $t6, go2
	sw $t3, 0($t5)
	addi $t5, $t5, 4
	j lo2
go2:	lw $t2, 152($sp)
	lw $t6, 100($sp)
	sw $t6, 12($t2)
	sw $t6, 16($t2)
	sw $t6, 140($t2)
	sw $t6, 144($t2)
	sw $t6, 268($t2)
	sw $t6, 272($t2)
	sw $t6, 396($t2)
	sw $t6, 400($t2)
	
	sw $t6, 136($t2)
	sw $t6, 148($t2)
	sw $t6, 264($t2)
	sw $t6, 276($t2)
	
	sw $t6, 28($t2)   #another 0
	sw $t6, 32($t2)
	sw $t6, 36($t2)
	sw $t6, 40($t2)
	sw $t6, 168($t2)   
	sw $t6, 296($t2)
	sw $t6, 424($t2)
	sw $t6, 420($t2)
	sw $t6, 416($t2)
	sw $t6, 412($t2)  #up
	sw $t6, 156($t2)
	sw $t6, 284($t2)		
	j elixir_remove					
									
change_sixty:	
	lw $t5, 152($sp)
	lw $t6, 148($sp)
	lw $t3, 20($sp)
lo3:	bge $t5, $t6, go3
	sw $t3, 0($t5)
	addi $t5, $t5, 4
	j lo3
go3:	lw $t2, 152($sp)
	lw $t6, 100($sp)
	sw $t6, 8($t2)   #0
	sw $t6, 12($t2)
	sw $t6, 16($t2)
	sw $t6, 20($t2)
	sw $t6, 392($t2)  #up
	sw $t6, 136($t2)
	sw $t6, 264($t2)
	sw $t6, 396($t2)
	sw $t6, 400($t2)	
	sw $t6, 404($t2)
	sw $t6, 276($t2)		
	sw $t6, 272($t2)
	sw $t6, 268($t2)	
	
	sw $t6, 28($t2)   #another 0
	sw $t6, 32($t2)
	sw $t6, 36($t2)
	sw $t6, 40($t2)
	sw $t6, 168($t2)   
	sw $t6, 296($t2)
	sw $t6, 424($t2)
	sw $t6, 420($t2)
	sw $t6, 416($t2)
	sw $t6, 412($t2)  #up
	sw $t6, 156($t2)
	sw $t6, 284($t2)											
	j elixir_remove	

change_forty: 
	lw $t5, 152($sp)
	lw $t6, 148($sp)
	lw $t3, 20($sp)
lo4:	bge $t5, $t6, go4
	sw $t3, 0($t5)
	addi $t5, $t5, 4
	j lo4
go4:	lw $t2, 152($sp)
	lw $t6, 100($sp)																																																																						
	sw $t6, 8($t2)   #4
	sw $t6, 136($t2)   
	sw $t6, 264($t2)
	sw $t6, 268($t2)   #4
	sw $t6, 272($t2)   
	sw $t6, 276($t2)	
	sw $t6, 144($t2)#stick
	sw $t6, 400($t2)#stick
	
	
	
	sw $t6, 28($t2)   #another 0
	sw $t6, 32($t2)
	sw $t6, 36($t2)
	sw $t6, 40($t2)
	sw $t6, 168($t2)   
	sw $t6, 296($t2)
	sw $t6, 424($t2)
	sw $t6, 420($t2)
	sw $t6, 416($t2)
	sw $t6, 412($t2)  #up
	sw $t6, 156($t2)
	sw $t6, 284($t2)																							
	j elixir_remove																	
																					
																								
																											
																																																																																																																																																																																																																
immortal_coll:


	#checks whether the ship has full health or not when colliding with immortality

	lw $t0, 36($sp)
	addi $t1, $t0, 128
	addi $t2, $t0, 256
	addi $t3, $t0, 124
	addi $t4, $t0, 120
	addi $t5, $t0, 248
	addi $t6, $t0, -8
	addi $t7, $t0, 132

	
	lw $s1, 108($sp)
	# if health is not full then it calls fulhealth to increase health to  100
	beq $t0, $s1, fullhealth
	beq $t1, $s1, fullhealth
	beq $t3, $s1, fullhealth
	beq $t4, $s1, fullhealth
	beq $t5, $s1, fullhealth
	beq $t6, $s1, fullhealth
	beq $t7, $s1, fullhealth
	beq $t2, $s1, fullhealth
	
	
	jr $ra
	
fullhealth:

	#makes health 100

	li $t4, 0
	sw $t4, 76($sp)
	
	sw $t4, 96($sp)
	
	lw $t5, 152($sp)
	lw $t6, 148($sp)
	lw $t3, 20($sp)
lo111:	bgt $t5, $t6, go111
	sw $t3, 0($t5)
	addi $t5, $t5, 4
	j lo111
	# line 2
	
go111:	lw $t2, 152($sp)
	lw $t6, 100($sp)
	sw $t6, 0($t2)   #1
	sw $t6, 128($t2)
	sw $t6, 256($t2)
	sw $t6, 384($t2)
	
	sw $t6, 8($t2)   #0
	sw $t6, 12($t2)
	sw $t6, 16($t2)
	sw $t6, 20($t2)
	sw $t6, 148($t2)   
	sw $t6, 276($t2)
	sw $t6, 404($t2)
	sw $t6, 400($t2)
	sw $t6, 396($t2)
	sw $t6, 392($t2)  #up
	sw $t6, 136($t2)
	sw $t6, 264($t2)

	sw $t6, 28($t2)   #another 0
	sw $t6, 32($t2)
	sw $t6, 36($t2)
	sw $t6, 40($t2)
	sw $t6, 168($t2)   
	sw $t6, 296($t2)
	sw $t6, 424($t2)
	sw $t6, 420($t2)
	sw $t6, 416($t2)
	sw $t6, 412($t2)  #up
	sw $t6, 156($t2)
	sw $t6, 284($t2)

	j health_touch_remove
	
elixir_edge_remove:

	#when the elixir touches the left boundary, it disappears and calls for creating a new
	lw $t5, 116($sp)
	lw $t6, 20($sp)
	
	
	sw $t6, 0($t5)
	
	j elixir_setup

elixir_remove:

	#this will remove the elixir bwtween the map when colliding with ship
	lw $t5, 116($sp)
	lw $t6, 0($sp)
	sw $t6, 0($t5)
	j elixir_setup
	
elixir_movt:


	lw $t2, 116($sp)
	
	lw $t7, 8($sp)
		
	#check wehther elixir touches the left boundary or not and if not move towards left by 1 pixel
	
	beq $t2, $t7, elixir_edge_remove	#1
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#2
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#3
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#4
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#5
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#6
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#7
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#8
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#9
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#10
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#11
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#12
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#13
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#14
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#15
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#16
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#17
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#18
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#19
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#20
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#21
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#22
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#23
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#24
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#25
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#26
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#27
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#28
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#29
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#30
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#31
	addi $t7, $t7, 128
	beq $t2, $t7, elixir_edge_remove	#32
	
	
	lw $t1, 112($sp)  
	addi $t4, $t2, -4
	lw $t3, 20($sp)  
	
	sw $t4, 116($sp)

	sw $t1, 0($t4)

	
	sw $t3, 0($t2)

	jr $ra
	
obstacle1:

	lw $t0, 24($sp)          # storing the initial position of object 1
	lw $t1, 128($sp)         # storing last position object 1 can go
o1mw:	beq $t0, $t1, leftremove1 # while condition of while(t0 != t1)  	
	lw $t2, 20($sp)         # storing the colour black
	lw $t3, 4($sp)          # storing the colour red
	sw $t2, 0($t0)          # colouring the current block to black
	sw $t2, 128($t0)        # colouring the below block to black
	sw $t2, 256($t0)        # colouring the third block to black
	add $t0, $t0, -4        # moving the one block to the left
	sw $t0, 24($sp)          # making the block to the left as current position of OBJ1
	sw $t3, 0($t0)          # colouring the current block to red
	sw $t3, 128($t0)        # colouring the below block to red
	sw $t3, 256($t0)        # colouring the third block to red
	jr $ra
leftremove1: 
	lw $s7, 124($sp)
	addi $s7, $s7, -25
	sw $s7, 124($sp)        # decreasing timer to increase difficulty.
	lw $t2, 20($sp)         #black color
	sw $t2, 0($t0)          # colouring the current block to black
	sw $t2, 128($t0)        # colouring the below block to black
	sw $t2, 256($t0)        # colouring the third block to black
	j obs1setup
	
	
obstacle2:
	lw $t0, 28($sp)          # storing the initial position of object 1
	lw $t1, 128($sp)         # storing last position object 1 can go
	beq $t0, $t1, leftremove2 # while condition of while(t0 != t1)  	
	lw $t2, 20($sp)         # storing the colour black
	lw $t3, 4($sp)          # storing the colour red
	sw $t2, 0($t0)          # colouring the current block to black
	sw $t2, 128($t0)        # colouring the below block to black
	sw $t2, 256($t0)        # colouring the third block to black
	add $t0, $t0, -4        # moving the one block to the left
	sw $t0, 28($sp)          # making the block to the left as current position of OBJ1
	sw $t3, 0($t0)          # colouring the current block to red
	sw $t3, 128($t0)        # colouring the below block to red
	sw $t3, 256($t0)        # colouring the third block to red
	jr $ra
leftremove2: 
	lw $t2, 20($sp)
	sw $t2, 0($t0)          # colouring the current block to black
	sw $t2, 128($t0)        # colouring the below block to black
	sw $t2, 256($t0)        # colouring the third block to black
	j obs2setup
	
obstacle3:

	# To move obstacle 3 to the left end of the screen
	
	lw $t0, 32($sp)          # storing the initial position of object 1
	lw $t1, 132($sp)         # storing last position object 1 can go
	beq $t0, $t1, leftremove3 # while condition of while(t0 != t1)  	
	lw $t2, 20($sp)         # storing the colour black
	lw $t3, 4($sp)          # storing the colour red
	sw $t2, 0($t0)          # colouring the current block to black
	sw $t2, 128($t0)        # colouring the below block to black
	sw $t2, 256($t0)        # colouring the third block to black
	add $t0, $t0, -4        # moving the one block to the left
	sw $t0, 32($sp)          # making the block to the left as current position of OBJ1
	sw $t3, 0($t0)          # colouring the current block to red
	sw $t3, 128($t0)        # colouring the below block to red
	sw $t3, 256($t0)        # colouring the third block to red
	jr $ra
leftremove3: 
	lw $t2, 20($sp)
	sw $t2, 0($t0)          # colouring the current block to black
	sw $t2, 128($t0)        # colouring the below block to black
	sw $t2, 256($t0)        # colouring the third block to black
	j obs3setup
	
	jr $ra
	
obstacle4:

	# To move obstacle 4 to the left end of the screen

	lw $t0, 40($sp)          # storing the initial position of object 1
	lw $t1, 132($sp)         # storing last position object 1 can go
	beq $t0, $t1, leftremove4 # while condition of while(t0 != t1)  	
	lw $t2, 20($sp)         # storing the colour black
	lw $t3, 4($sp)          # storing the colour red
	sw $t2, 0($t0)          # colouring the current block to black
	sw $t2, 128($t0)        # colouring the below block to black
	sw $t2, 256($t0)        # colouring the third block to black
	add $t0, $t0, -4        # moving the one block to the left
	sw $t0, 40($sp)          # making the block to the left as current position of OBJ1
	sw $t3, 0($t0)          # colouring the current block to red
	sw $t3, 128($t0)        # colouring the below block to red
	sw $t3, 256($t0)        # colouring the third block to red
	jr $ra
leftremove4: 
	lw $t2, 20($sp)
	sw $t2, 0($t0)          # colouring the current block to black
	sw $t2, 128($t0)        # colouring the below block to black
	sw $t2, 256($t0)        # colouring the third block to black
	j obs4setup

	
	
enemy_coll:


#checks whether the enemy ship  collides with the user's ship
	lw $t0, 36($sp)  
	addi $t1, $t0, 128
	addi $t2, $t0, 256
	addi $t7, $t0, 248
	addi $t3, $t0, 132
	addi $t4, $t0, 124
	addi $t5, $t0, -8
	addi $t6, $t0, 120
	
	
	
	lw $t9, 104($sp)   # enemy location 

	
	#if yes then it does towards the ending to close the game

	
	beq $t0, $t9, end_back_setup
	beq $t1, $t9, end_back_setup
	beq $t2, $t9, end_back_setup
	beq $t3, $t9, end_back_setup
	beq $t4, $t9, end_back_setup
	beq $t5, $t9, end_back_setup
	beq $t6, $t9, end_back_setup
	beq $t7, $t9, end_back_setup

	jr $ra

obstaclecollision1:


	lw $t0, 36($sp)         #loading current ship pos
	addi $t1, $t0, 128      #loading the ship centre block
	addi $t2, $t0, 256       #loading the ship bottom block
	addi $t3, $t0, 132
	addi $t4, $t0, 124
	addi $t5, $t0, -8
	addi $t6, $t0, 120
	addi $t7, $t0, 248
	
	
	lw $s3, 24($sp)         #loading obstacle 1's current position
	addi $s4, $s3, 128      #loading the obstacle centre block
	addi $s5, $s3, 256 #loading the obstacle bottom block
	
#shows yellow spaceship when colliding with obstacle
	li $s6, 1
	sw $s6, 156($sp)
	beq $t0, $s3, ship_obstacle_color

	beq $t1, $s3, ship_obstacle_color

	beq $t2, $s3, ship_obstacle_color
	
	beq $t3, $s3, ship_obstacle_color

	beq $t4, $s3, ship_obstacle_color

	beq $t5, $s3, ship_obstacle_color
	
	beq $t6, $s3, ship_obstacle_color

	beq $t9, $s3, ship_obstacle_color

	
	beq $t0, $s5, ship_obstacle_color

	beq $t1, $s5, ship_obstacle_color

	beq $t2, $s5, ship_obstacle_color
	
	beq $t3, $s5, ship_obstacle_color

	beq $t4, $s5, ship_obstacle_color

	beq $t5, $s5, ship_obstacle_color
	
	beq $t6, $s5, ship_obstacle_color

	beq $t9, $s5, ship_obstacle_color


	beq $t0, $s4, ship_obstacle_color

	beq $t1, $s4, ship_obstacle_color

	beq $t2, $s4, ship_obstacle_color
	
	beq $t3, $s4, ship_obstacle_color

	beq $t4, $s4, ship_obstacle_color

	beq $t5, $s4, ship_obstacle_color
	
	beq $t6, $s4, ship_obstacle_color

	beq $t9, $s4, ship_obstacle_color
        li $s6, 0
	sw $s6, 156($sp)

	
	jr $ra
	
obstaclecollision2:

	
	
	lw $t0, 36($sp)         #loading current ship pos
	addi $t1, $t0, 128      #loading the ship centre block
	addi $t2, $t0, 256       #loading the ship bottom block
	addi $t3, $t0, 132
	addi $t4, $t0, 124
	addi $t5, $t0, -8
	addi $t6, $t0, 120
	addi $t9, $t0, 248
	
	
	lw $s3, 28($sp)         #loading obstacle 1's current position
	addi $s4, $s3, 128      #loading the obstacle centre block
	addi $s5, $s3, 256 #loading the obstacle bottom block
	
	
	
	lw $t7, 0($sp)     #loading green colour
         
#shows yellow spaceship when colliding with obstacle
	li $s6, 2
	sw $s6, 156($sp)
	beq $t0, $s3, ship_obstacle_color

	beq $t1, $s3, ship_obstacle_color

	beq $t2, $s3, ship_obstacle_color
	
	beq $t3, $s3, ship_obstacle_color

	beq $t4, $s3, ship_obstacle_color

	beq $t5, $s3, ship_obstacle_color
	
	beq $t6, $s3, ship_obstacle_color

	beq $t9, $s3, ship_obstacle_color

	
	beq $t0, $s5, ship_obstacle_color

	beq $t1, $s5, ship_obstacle_color

	beq $t2, $s5, ship_obstacle_color
	
	beq $t3, $s5, ship_obstacle_color

	beq $t4, $s5, ship_obstacle_color

	beq $t5, $s5, ship_obstacle_color
	
	beq $t6, $s5, ship_obstacle_color

	beq $t9, $s5, ship_obstacle_color


	beq $t0, $s4, ship_obstacle_color

	beq $t1, $s4, ship_obstacle_color

	beq $t2, $s4, ship_obstacle_color
	
	beq $t3, $s4, ship_obstacle_color

	beq $t4, $s4, ship_obstacle_color

	beq $t5, $s4, ship_obstacle_color
	
	beq $t6, $s4, ship_obstacle_color

	beq $t9, $s4, ship_obstacle_color
        li $s6, 0
	sw $s6, 156($sp)

	
	jr $ra
	
obstaclecollision3:

	
	
	lw $t0, 36($sp)         #loading current ship pos
	addi $t1, $t0, 128      #loading the ship centre block
	addi $t2, $t0, 256       #loading the ship bottom block
	addi $t3, $t0, 132
	addi $t4, $t0, 124
	addi $t5, $t0, -8
	addi $t6, $t0, 120
	addi $t9, $t0, 248
	
	
	lw $s3, 32($sp)         #loading obstacle 1's current position
	addi $s4, $s3, 128      #loading the obstacle centre block
	addi $s5, $s3, 256 #loading the obstacle bottom block
	

         
	#shows yellow spaceship when colliding with obstacle
	li $s6, 3
	sw $s6, 156($sp)
	beq $t0, $s3, ship_obstacle_color

	beq $t1, $s3, ship_obstacle_color

	beq $t2, $s3, ship_obstacle_color
	
	beq $t3, $s3, ship_obstacle_color

	beq $t4, $s3, ship_obstacle_color

	beq $t5, $s3, ship_obstacle_color
	
	beq $t6, $s3, ship_obstacle_color

	beq $t9, $s3, ship_obstacle_color

	
	beq $t0, $s5, ship_obstacle_color

	beq $t1, $s5, ship_obstacle_color

	beq $t2, $s5, ship_obstacle_color
	
	beq $t3, $s5, ship_obstacle_color

	beq $t4, $s5, ship_obstacle_color

	beq $t5, $s5, ship_obstacle_color
	
	beq $t6, $s5, ship_obstacle_color

	beq $t9, $s5, ship_obstacle_color


	beq $t0, $s4, ship_obstacle_color

	beq $t1, $s4, ship_obstacle_color

	beq $t2, $s4, ship_obstacle_color
	
	beq $t3, $s4, ship_obstacle_color

	beq $t4, $s4, ship_obstacle_color

	beq $t5, $s4, ship_obstacle_color
	
	beq $t6, $s4, ship_obstacle_color

	beq $t9, $s4, ship_obstacle_color
        li $s6, 0
	sw $s6, 156($sp)

	
	jr $ra
obstaclecollision4:
lw $t0, 36($sp)         #loading current ship pos
	addi $t1, $t0, 128      #loading the ship centre block
	addi $t2, $t0, 256       #loading the ship bottom block
	addi $t3, $t0, 132
	addi $t4, $t0, 124
	addi $t5, $t0, -8
	addi $t6, $t0, 120
	addi $t9, $t0, 248
	
	
	lw $s3, 40($sp)         #loading obstacle 1's current position
	addi $s4, $s3, 128      #loading the obstacle centre block
	addi $s5, $s3, 256 #loading the obstacle bottom block
	
	
	
	 
         
#shows yellow spaceship when colliding with obstacle
	li $s6, 4
	sw $s6, 156($sp)
	beq $t0, $s3, ship_obstacle_color

	beq $t1, $s3, ship_obstacle_color

	beq $t2, $s3, ship_obstacle_color
	
	beq $t3, $s3, ship_obstacle_color

	beq $t4, $s3, ship_obstacle_color

	beq $t5, $s3, ship_obstacle_color
	
	beq $t6, $s3, ship_obstacle_color

	beq $t9, $s3, ship_obstacle_color

	
	beq $t0, $s5, ship_obstacle_color

	beq $t1, $s5, ship_obstacle_color

	beq $t2, $s5, ship_obstacle_color
	
	beq $t3, $s5, ship_obstacle_color

	beq $t4, $s5, ship_obstacle_color

	beq $t5, $s5, ship_obstacle_color
	
	beq $t6, $s5, ship_obstacle_color

	beq $t9, $s5, ship_obstacle_color


	beq $t0, $s4, ship_obstacle_color

	beq $t1, $s4, ship_obstacle_color

	beq $t2, $s4, ship_obstacle_color
	
	beq $t3, $s4, ship_obstacle_color

	beq $t4, $s4, ship_obstacle_color

	beq $t5, $s4, ship_obstacle_color
	
	beq $t6, $s4, ship_obstacle_color

	beq $t9, $s4, ship_obstacle_color
        li $s6, 0
	sw $s6, 156($sp)

	
	jr $ra
	


ship_obstacle_color:
	
	
	lw $t0, 60($sp)  #collision color
	
	lw $s0, 36($sp)  #sp start pos
	
	sw $t0, 0($s0)  
	sw $t0, 128($s0)
	sw $t0, 256($s0)
	sw $t0, 132($s0)  
	sw $t0, 124($s0)
	sw $t0, -8($s0)
	sw $t0, 120($s0)  
	sw $t0, 248($s0)
	
	lw $s1, 76($sp)  
	addi $s1, $s1, 1
	sw $s1, 76($sp)
	
	#this is for decreasing the health on colliding with the obstacle
	
	lw $t2, 100($sp)    # health bg color
	
	lw $s2, 72($sp)    # max
	
	lw $t7, 8($sp)	   # Base Address
	lw $t5, 152($sp)
	li $t6, 0
	lw $t6, 148($sp)
	lw $t3, 20($sp)
		
	beq $s1, 0, hundred
	beq $s1, 1, eighty
	beq $s1, 2, sixty
	beq $s1, 3, forty	
	beq $s1, 4, twenty	
	beq $s1, 5, here
	
hundred:	

lo11:	bge $t5, $t6, go11
	sw $t3, 0($t5)
	addi $t5, $t5, 4
	j lo11
go11:	lw $t2, 152($sp)
	lw $t6, 100($sp)
	sw $t6, 0($t2)   #1
	sw $t6, 128($t2)
	sw $t6, 256($t2)
	sw $t6, 384($t2)
	
	sw $t6, 8($t2)   #0
	sw $t6, 12($t2)
	sw $t6, 16($t2)
	sw $t6, 20($t2)
	sw $t6, 148($t2)   
	sw $t6, 276($t2)
	sw $t6, 404($t2)
	sw $t6, 400($t2)
	sw $t6, 396($t2)
	sw $t6, 392($t2)  #up
	sw $t6, 136($t2)
	sw $t6, 264($t2)

	sw $t6, 28($t2)   #another 0
	sw $t6, 32($t2)
	sw $t6, 36($t2)
	sw $t6, 40($t2)
	sw $t6, 168($t2)   
	sw $t6, 296($t2)
	sw $t6, 424($t2)
	sw $t6, 420($t2)
	sw $t6, 416($t2)
	sw $t6, 412($t2)  #up
	sw $t6, 156($t2)
	sw $t6, 284($t2)
	j here

eighty:	

lo22:	bge $t5, $t6, go22
	sw $t3, 0($t5)
	addi $t5, $t5, 4
	j lo22
go22:	lw $t2, 152($sp)
	lw $t6, 100($sp)
	sw $t6, 12($t2)
	sw $t6, 16($t2)
	sw $t6, 140($t2)
	sw $t6, 144($t2)
	sw $t6, 268($t2)
	sw $t6, 272($t2)
	sw $t6, 396($t2)
	sw $t6, 400($t2)
	
	sw $t6, 136($t2)
	sw $t6, 148($t2)
	sw $t6, 264($t2)
	sw $t6, 276($t2)
	
	sw $t6, 28($t2)   #another 0
	sw $t6, 32($t2)
	sw $t6, 36($t2)
	sw $t6, 40($t2)
	sw $t6, 168($t2)   
	sw $t6, 296($t2)
	sw $t6, 424($t2)
	sw $t6, 420($t2)
	sw $t6, 416($t2)
	sw $t6, 412($t2)  #up
	sw $t6, 156($t2)
	sw $t6, 284($t2)		
	j here					
									
sixty:	

lo33:	bge $t5, $t6, go33
	sw $t3, 0($t5)
	addi $t5, $t5, 4
	j lo33
go33:	lw $t2, 152($sp)
	lw $t6, 100($sp)
	sw $t6, 8($t2)   #0
	sw $t6, 12($t2)
	sw $t6, 16($t2)
	sw $t6, 20($t2)
	sw $t6, 392($t2)  #up
	sw $t6, 136($t2)
	sw $t6, 264($t2)
	sw $t6, 396($t2)
	sw $t6, 400($t2)	
	sw $t6, 404($t2)
	sw $t6, 276($t2)		
	sw $t6, 272($t2)
	sw $t6, 268($t2)	
	
	sw $t6, 28($t2)   #another 0
	sw $t6, 32($t2)
	sw $t6, 36($t2)
	sw $t6, 40($t2)
	sw $t6, 168($t2)   
	sw $t6, 296($t2)
	sw $t6, 424($t2)
	sw $t6, 420($t2)
	sw $t6, 416($t2)
	sw $t6, 412($t2)  #up
	sw $t6, 156($t2)
	sw $t6, 284($t2)											
	j here	

forty: 

lo44:	bge $t5, $t6, go44
	sw $t3, 0($t5)
	addi $t5, $t5, 4
	j lo44
go44:	lw $t2, 152($sp)
	lw $t6, 100($sp)																																																																						
	sw $t6, 8($t2)   #4
	sw $t6, 136($t2)   
	sw $t6, 264($t2)
	sw $t6, 268($t2)   #4
	sw $t6, 272($t2)   
	sw $t6, 276($t2)	
	sw $t6, 144($t2)#stick
	sw $t6, 400($t2)#stick
	
	
	
	sw $t6, 28($t2)   #another 0
	sw $t6, 32($t2)
	sw $t6, 36($t2)
	sw $t6, 40($t2)
	sw $t6, 168($t2)   
	sw $t6, 296($t2)
	sw $t6, 424($t2)
	sw $t6, 420($t2)
	sw $t6, 416($t2)
	sw $t6, 412($t2)  #up
	sw $t6, 156($t2)
	sw $t6, 284($t2)																							
	j here																	
																					
twenty:	
lo55:	bge $t5, $t6, go55
	sw $t3, 0($t5)
	addi $t5, $t5, 4
	j lo55
go55:	lw $t2, 152($sp)
	lw $t6, 100($sp)
	sw $t6, 8($t2)   #0
	sw $t6, 12($t2)
	sw $t6, 16($t2)
	sw $t6, 20($t2)
	
	sw $t6, 148($t2) #up two
	sw $t6, 144($t2)
	
	sw $t6, 268($t2)#down two
	sw $t6, 264($t2)
	
	sw $t6, 404($t2)
	sw $t6, 400($t2)
	sw $t6, 396($t2)
	sw $t6, 392($t2)





	sw $t6, 28($t2)   #another 0
	sw $t6, 32($t2)
	sw $t6, 36($t2)
	sw $t6, 40($t2)
	sw $t6, 168($t2)   
	sw $t6, 296($t2)
	sw $t6, 424($t2)
	sw $t6, 420($t2)
	sw $t6, 416($t2)
	sw $t6, 412($t2)  #up
	sw $t6, 156($t2)
	sw $t6, 284($t2)
	# If collision number reaches 5 which is the max level we have to call another function to show black screen
	# which then call to show a game over screen

here:	beq $s1, $s2, end_back_setup
	beq $s6, 1, one
	beq $s6, 2, two
	beq $s6, 3, three
	beq $s6, 4, four
two:     	
	lw $s3, 28($sp)         #loading obstacle 1's current position
	lw $t9, 20($sp)
	sw $t9, 0($s3)
	sw $t9, 128($s3)
	sw $t9, 256($s3)
	addi $s4, $s3, 128      #loading the obstacle centre block
	addi $s5, $s3, 256 #loading the obstacle bottom block
	addi, $s3, $s3, -20	
	addi, $s4, $s4, -20
	addi, $s5, $s5, -20	
	sw $s3, 28($sp)
	
	#sleep
	li $v0, 32
	li $a0, 50
	syscall 
	lw $t1 0($sp)
	
	lw $t0, 36($sp)
	
	sw $t1 0($t0)
	sw $t1 128($t0)
	sw $t1 256($t0)
	sw $t1 124($t0)
	sw $t1 120($t0)
	sw $t1 248($t0)
	sw $t1 -8($t0)
	sw $t1 132($t0)
	j main1
one:     	
	lw $s3, 24($sp)         #loading obstacle 1's current position
	lw $t9, 20($sp)
	sw $t9, 0($s3)
	sw $t9, 128($s3)
	sw $t9, 256($s3)
	addi $s4, $s3, 128      #loading the obstacle centre block
	addi $s5, $s3, 256 #loading the obstacle bottom block
	addi, $s3, $s3, -20	
	addi, $s4, $s4, -20
	addi, $s5, $s5, -20	
	sw $s3, 24($sp)
	
	#sleep
	li $v0, 32
	li $a0, 50
	syscall 
	lw $t1 0($sp)
	
	lw $t0, 36($sp)
	
	sw $t1 0($t0)
	sw $t1 128($t0)
	sw $t1 256($t0)
	sw $t1 124($t0)
	sw $t1 120($t0)
	sw $t1 248($t0)
	sw $t1 -8($t0)
	sw $t1 132($t0)
	j main1	
	#sleep
	
	
three:     	
	lw $s3, 32($sp)         #loading obstacle 1's current position
	lw $t9, 20($sp)
	sw $t9, 0($s3)
	sw $t9, 128($s3)
	sw $t9, 256($s3)
	addi $s4, $s3, 128      #loading the obstacle centre block
	addi $s5, $s3, 256 #loading the obstacle bottom block
	addi, $s3, $s3, -20	
	addi, $s4, $s4, -20
	addi, $s5, $s5, -20	
	sw $s3, 32($sp)
	
	#sleep
	li $v0, 32
	li $a0, 50
	syscall 
	lw $t1 0($sp)
	
	lw $t0, 36($sp)
	
	sw $t1 0($t0)
	sw $t1 128($t0)
	sw $t1 256($t0)
	sw $t1 124($t0)
	sw $t1 120($t0)
	sw $t1 248($t0)
	sw $t1 -8($t0)
	sw $t1 132($t0)
	j main1	
	
	
four:     	
	lw $s3, 40($sp)         #loading obstacle 1's current position
	lw $t9, 20($sp)
	sw $t9, 0($s3)
	sw $t9, 128($s3)
	sw $t9, 256($s3)
	addi $s4, $s3, 128      #loading the obstacle centre block
	addi $s5, $s3, 256 #loading the obstacle bottom block
	addi, $s3, $s3, -20	
	addi, $s4, $s4, -20
	addi, $s5, $s5, -20	
	sw $s3, 40($sp)
	
	#sleep
	li $v0, 32
	li $a0, 50
	syscall 
	lw $t1 0($sp)
	
	lw $t0, 36($sp)
	
	sw $t1 0($t0)
	sw $t1 128($t0)
	sw $t1 256($t0)
	sw $t1 124($t0)
	sw $t1 120($t0)
	sw $t1 248($t0)
	sw $t1 -8($t0)
	sw $t1 132($t0)
	j main1
	
	
	li $v0, 32
	li $a0, 50
	syscall 
	j main1
	

end_back_setup:

	#setting the bottom right add
	
	lw $t2, 8($sp)     # contains base address
	
	addi $t3, $t2, 4147

end_back:

	#coloring the screenw with black

	bge $t2, $t3, end

	lw $t1, 20($sp)		
	sw $t1 0($t2)
	
	addi $t2, $t2, 4
	j end_back
	
	
	
end:
	lw $t6, 100($sp)
	lw $t1, 8($sp)
	# making E
	sw $t6, 1536($t1)    #E top line
	sw $t6, 1664($t1)
	sw $t6, 1792($t1)
	sw $t6, 1920($t1)
	sw $t6, 2048($t1)     #E bottom line
	sw $t6, 2176($t1)   
	sw $t6, 2304($t1)
	sw $t6, 2432($t1)
	sw $t6, 2560($t1)    #E bottom line
	
	
	sw $t6, 1540($t1)    #E top line horizontal
	sw $t6, 1544($t1)
	sw $t6, 1548($t1)
	sw $t6, 1552($t1)
	sw $t6, 2052($t1)     #E middle line horizontal
	sw $t6, 2056($t1)   
	sw $t6, 2564($t1)    #E bottom line horizontal
	sw $t6, 2568($t1)
	sw $t6, 2572($t1)  
	sw $t6, 2576($t1) 
	
	#making D
	sw $t6, 1640($t1)    #Dtop line
	sw $t6, 1768($t1)
	sw $t6, 1896($t1)
	sw $t6, 2024($t1)
	sw $t6, 2152($t1)     #D bottom line
	sw $t6, 2280($t1)   
	sw $t6, 2408($t1)
	sw $t6, 2536($t1)
	sw $t6, 2664($t1)    #D bottom line
	
	
	sw $t6, 1644($t1)	
	sw $t6, 1776($t1)
	sw $t6, 1908($t1)
	sw $t6, 2040($t1)
	sw $t6, 2172($t1)    
	sw $t6, 2296($t1)   
	sw $t6, 2420($t1)
	sw $t6, 2544($t1)
	sw $t6, 2668($t1)


	#making N
	sw $t6, 1048($t1)   #E first vertical line
	sw $t6, 1176($t1)    
	sw $t6, 1304($t1)    	
	sw $t6, 1432($t1)    		
	sw $t6, 1560($t1)    
	sw $t6, 1688($t1)
	sw $t6, 1816($t1)
	sw $t6, 1944($t1)
	sw $t6, 2072($t1)     
	sw $t6, 2200($t1)   
	sw $t6, 2328($t1)
	sw $t6, 2456($t1)
	sw $t6, 2584($t1)    
	sw $t6, 2712($t1)
	sw $t6, 2840($t1)    
	sw $t6, 2968($t1)
	sw $t6, 3096($t1)
	
	
	sw $t6, 1120($t1)   #E second vertical line
	sw $t6, 1248($t1)    
	sw $t6, 1376($t1)    	
	sw $t6, 1504($t1)    		
	sw $t6, 1632($t1)    
	sw $t6, 1760($t1)
	sw $t6, 1888($t1)
	sw $t6, 2016($t1)
	sw $t6, 2144($t1)     
	sw $t6, 2272($t1)   
	sw $t6, 2400($t1)
	sw $t6, 2528($t1)
	sw $t6, 2656($t1)    
	sw $t6, 2784($t1)
	sw $t6, 2912($t1)    
	sw $t6, 3040($t1)
	sw $t6, 3168($t1)

	sw $t6, 1052($t1)    #diagonal
	sw $t6, 1184($t1)    
	sw $t6, 1316($t1)    	
	sw $t6, 1448($t1)    		
	sw $t6, 1580($t1)    
	sw $t6, 1712($t1)
	sw $t6, 1844($t1)
	sw $t6, 1976($t1)
	sw $t6, 2108($t1)     
	sw $t6, 2240($t1)   
	sw $t6, 2372($t1)
	sw $t6, 2504($t1)
	sw $t6, 2636($t1)    
	sw $t6, 2768($t1)
	sw $t6, 2900($t1)    
	sw $t6, 3032($t1)
	sw $t6, 3164($t1)	
	
	# Exiting game
	
	#Sleep
	li $v0, 32
	li $a0, 1500
	syscall
	
	li $v0, 10 # terminate the program gracefully
	syscall
	
	
end_p:
	
	# Setting gaame speed back to the speed which was at the begining 
	lw $s7, 124($sp)
	li $s7, 300
	sw $s7, 124($sp)


	# Thus function will also print "END" and is being exectued when we press "p" to restart the game

	lw $t6, 100($sp)
	lw $t1, 8($sp)
	
	# MADE E

	# making E
	sw $t6, 1536($t1)    #E top line
	sw $t6, 1664($t1)
	sw $t6, 1792($t1)
	sw $t6, 1920($t1)
	sw $t6, 2048($t1)     #E bottom line
	sw $t6, 2176($t1)   
	sw $t6, 2304($t1)
	sw $t6, 2432($t1)
	sw $t6, 2560($t1)    #E bottom line
	
	
	sw $t6, 1540($t1)    #E top line horizontal
	sw $t6, 1544($t1)
	sw $t6, 1548($t1)
	sw $t6, 1552($t1)
	sw $t6, 2052($t1)     #E middle line horizontal
	sw $t6, 2056($t1)   
	sw $t6, 2564($t1)    #E bottom line horizontal
	sw $t6, 2568($t1)
	sw $t6, 2572($t1)  
	sw $t6, 2576($t1) 
	
	#making D
	sw $t6, 1640($t1)    #Dtop line
	sw $t6, 1768($t1)
	sw $t6, 1896($t1)
	sw $t6, 2024($t1)
	sw $t6, 2152($t1)     #D bottom line
	sw $t6, 2280($t1)   
	sw $t6, 2408($t1)
	sw $t6, 2536($t1)
	sw $t6, 2664($t1)    #D bottom line
	
	
	sw $t6, 1644($t1)	
	sw $t6, 1776($t1)
	sw $t6, 1908($t1)
	sw $t6, 2040($t1)
	sw $t6, 2172($t1)    
	sw $t6, 2296($t1)   
	sw $t6, 2420($t1)
	sw $t6, 2544($t1)
	sw $t6, 2668($t1)


	#making N
	sw $t6, 1048($t1)   #E first vertical line
	sw $t6, 1176($t1)    
	sw $t6, 1304($t1)    	
	sw $t6, 1432($t1)    		
	sw $t6, 1560($t1)    
	sw $t6, 1688($t1)
	sw $t6, 1816($t1)
	sw $t6, 1944($t1)
	sw $t6, 2072($t1)     
	sw $t6, 2200($t1)   
	sw $t6, 2328($t1)
	sw $t6, 2456($t1)
	sw $t6, 2584($t1)    
	sw $t6, 2712($t1)
	sw $t6, 2840($t1)    
	sw $t6, 2968($t1)
	sw $t6, 3096($t1)
	
	
	sw $t6, 1120($t1)   #E second vertical line
	sw $t6, 1248($t1)    
	sw $t6, 1376($t1)    	
	sw $t6, 1504($t1)    		
	sw $t6, 1632($t1)    
	sw $t6, 1760($t1)
	sw $t6, 1888($t1)
	sw $t6, 2016($t1)
	sw $t6, 2144($t1)     
	sw $t6, 2272($t1)   
	sw $t6, 2400($t1)
	sw $t6, 2528($t1)
	sw $t6, 2656($t1)    
	sw $t6, 2784($t1)
	sw $t6, 2912($t1)    
	sw $t6, 3040($t1)
	sw $t6, 3168($t1)

	sw $t6, 1052($t1)    #diagonal
	sw $t6, 1184($t1)    
	sw $t6, 1316($t1)    	
	sw $t6, 1448($t1)    		
	sw $t6, 1580($t1)    
	sw $t6, 1712($t1)
	sw $t6, 1844($t1)
	sw $t6, 1976($t1)
	sw $t6, 2108($t1)     
	sw $t6, 2240($t1)   
	sw $t6, 2372($t1)
	sw $t6, 2504($t1)
	sw $t6, 2636($t1)    
	sw $t6, 2768($t1)
	sw $t6, 2900($t1)    
	sw $t6, 3032($t1)
	sw $t6, 3164($t1)
	
	
	#Sleep
	li $v0, 32
	li $a0, 1500
	syscall
	
	j new_screen_black
	
new_screen_black:

#setting the screen back again for a new game
	lw $t2, 8($sp)    
	
	addi $t3, $t2, 4147

black_screen2:


	bge $t2, $t3, mainsetup

	lw $t1, 20($sp)		
	sw $t1 0($t2)
	
	addi $t2, $t2, 4
	j black_screen2
	

	
	
	


