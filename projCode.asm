		
		
		##################################################################################
		#										 #
		#			ENCS4370: COMPUTER ARCHITECTURE         	         #
		#			       Course Project 1 :				 #
		#			Layer Neural Networks (Perceptron):                      #
		#										 #
		#				                        			 #			      
		#	Student Name: Maen Khdour 		ID: 1171944 		sec:1 	 #			      
		#                                                                                #
		#										 #
		##################################################################################								              

.data  
#arrays to sotre
	list:  .space 1024 			# contain the weight
	ep: .word 4 				# to sotre the number of epoch
	mom: .float 4	 			# to store the momentum
	le: .float 4  				# to store the learinig rate
	thr: .float 4  				# to store the threshold
	store: .space 1024 			# array to store content of file on it 
	after:.space 1024 			# array to store content of file after split the comma
	ZeroFloat: .float 0.0 			# contain 0 
	OneFloat: .float 1.0			# contain 1
		
#Messages
	Welcom:.asciiz "\t\t\t\t\tLayer Neural Networks (Perceptron)Project"
	Names: .asciiz "\t\t\t\t\tMaen Khdour 1171944 | Aminah Abo Shlbaya 1170963 "
	table_con: .asciiz "\t\tX1\tI_W1\tX2\tI_W2\tY_d\tY_actual\tError(e)\tN_W1\tN_w2\tLearR\tMomentum\tThreshold"
	n_ep: .asciiz "Epoch: "
	space:.asciiz "\t"
	learning_value:.asciiz "Learning rate = "
	Momentum_value:.asciiz "Momentum = "
	threshold_value:.asciiz "Threshold = "
	sort:.asciiz"Data after split and sort:"
	errorfile: .asciiz " Error in reading file, PLease check the name of the input file "
	wt1: .asciiz "Enter The Weight:"    
	training : .asciiz "Please enter the name of the training file: "
	epochN  : .asciiz "PLease enter the number of epochs: "
	momentum: .asciiz "Enter The momentum:" 
	learn: .asciiz "Enter The value of  learining rate:"  
	threshold: .asciiz "Enter The value of threshold:"  
	fin: .asciiz ""	 #sotre the file name
	

.text 
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#

#Dispaly message name and the project
    ##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
    ##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
	li $v0,4                  		# code call print string message 
   	la $a0, Welcom		 	        # message Name of project
   	syscall
   	
   ##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
   	li $v0,4                 		# code call print string message 
   	la $a0, Names		  		# message print names
   	syscall
   	
   	##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
   	
	################
#Display message of Number of epoch:
	li $v0,4                 		# code call print string message 
   	la $a0, epochN		  		# message to enter the number of epoch
   	syscall
   
#Read from user 
   	li $v0,5  				# code read from user an Integer
   	syscall
   	sw $v0, ep            			#sotre the value of epoch in the varaible ep
   	
##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
   	
#*********************************#

#Display message of momentum: 
  	li $v0,4                	       # code call print string message 
   	la $a0, momentum       		       # message to enter the value of mom
   	syscall
   
#Read from user 
   	li $v0,6               		       # code read from user an floating-point
   	syscall
   	swc1 $f0, mom           	       #sotre the value of momentum in the varaible mom
	
##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
   	
#**************************#

#Display message of learining rate:
	li $v0,4                	       # code call print string message 
   	la $a0, learn		 	       # message to enter the value of learinig rate
   	syscall
   
#Read from user 
  	li $v0,6                	       # code read from user an floating-point
   	syscall
   	swc1 $f0, le            	       #sotre the value of learning-rate in the varaible le
   	
##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
#**************************#

#Display message of threshold:
	li $v0,4                 		# code call print string message 
   	la $a0, threshold		        # message
   	syscall
   
#Read from user 
   	li $v0,6               		        # code read from user an floating-point
	syscall
   	swc1 $f0, thr                           #sotre the value of threshold in the varaible thr
   	
##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
   	
 ## reading the file data and entering it
 
read_file:  

#Display message of training :
  	li $v0,4 				# code call print string 
  	la $a0, training	 		# message to enter the name of file 
 	syscall
   
## Getting user 's inpout text
	li $v0,8  				# tell the system to prepare to get text
	la $a0, fin  				# store the name of file
	li $a1,20 				#tell the system the maximum length 20char or 20 Byte
	syscall 
	
	
#remove the new line charachter 
	la $a0,fin 				# pass filename to $a0 register
	add $a0,$a0,100	 			# add 100 to $a0, 
		
# finding the new line character

remove_enter:
	lb $v0,0($a0) 				# get buffer character value
	bne $v0,$zero, end 			# if reached the end
	sub $a0,$a0,1 				# subtracting 1 from $a0
	j remove_enter
end: 						# define end of line 
	sb $zero,0($a0) 			# replace the new line character with null

#-----------------------------------------------------#
# Open (for reading) a file
	li $v0, 13      		        # system call for open file
	la $a0, fin     			# output file name that we store it 
	li $a1, 0        			# flags to read mode
	syscall          			# open a file (file descriptor returned in $v0)
	bltz $v0, error_input_file     		# if $v0 is less than 0, there is an error found
	move $t0,$v0 	   			# save file descriptor in $t0
     
# Read to file 
	li $v0, 14       			# system call for read to file
	la $a1, store    			# address of buffer from which to write
  	li $a2, 1024     			# hardcoded buffer length
  	move $a0, $t0    			# put the file descriptor in $a0		
  	syscall         		        # write to file

# Close the file 
  	li $v0, 16       			# system call for close file
  	move $a0, $t0    			# Restore fd
  	syscall          			# close file
#**************************#	

################################################

#split and store
	la $s0,store  				# laod address store
	addi $t0,$0,0 				# clear reg t0
loop:
	lb $s1,0($s0)				#load byte to read byte by byte
	addi $s0,$s0,1				# incr index 
	beq $s1,0 ,exit				#if file end
	blt $s1,48,skip	 			#compare with asccii
	bgt $s1,57,skip				#compare with asccii
	subi $s1,$s1,48 			# ro return from asccii to number
	sb $s1,after($t0)			#store the value
	addi $t0,$t0,1				#increase 
skip:
	j loop
	
exit:	

#############################################

# print content of array 
   	move $s4,$0 	 			#clear
   	addi $t0,$0,13   			# soter the size of array

#print new line & Message

##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
        
	li $v0,4               		        # code call print string message 
   	la $a0, sort	 			# message to print the sort file will be
   	syscall
##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
  ############ 
   	
	loop2: 
		beq $t0,0 ,exit5		#compare
		subi $t0,$t0,1	       		#read array 
		
		
	lb $s3,after($s4)	 		#load array after in s3
	move $a0,$s3 				# move content of s3 to be in a0 to print
	li $v0,1 				# call print
	addi $s4,$s4,1				#increase the index 
	syscall
	j loop2			

exit5:
##print new line

##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
   	
#*********************************#

#get the array into a register

	la $t3, after 				# put address of list into $t3
	lb $t4, 0($t3) 				# get the value from the array cell (number of featers)
	move $s1,$t4   				# number of featers from file
	addi $t0,$0,0    			# clear reg t0
	sub.s $f1,$f1,$f1	
loopw:
##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
   	
	beq $s1,0 ,exitw			#if file end
	li $v0,4               			#code call print string message 
        la $a0, wt1				#load address of wt1 message 
        syscall
        
        li $v0, 6             		        #read float from the user
        syscall
        
        mov.s $f1,$f0
        swc1 $f1, list($t0)    			#store the floating-point to the array
        subi $s1,$s1,1         			#dec num of featers by 1
        addi $t0,$t0,4         			#inc by 4 because every integer need 4 bytes
  
        j loopw
 
exitw:
##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
        
#################################################


	or $t0,$0,$0    			# clear reg t0
     	or $t4,$0,$0 	 			# clear tef t4
     	
	lwc1 $f0,ZeroFloat			# put zero to f0 
	lw $s5,ep 				#store value of epoch in s5
	
   
#LOOPS and ITRATION:

Loop_Number_Epoch:
	
	beq $s5,0,End_Programe			#to jump when s5=0
	subi $s5,$s5,1 				#decrement
	or $t2,$0,$0    			#clear reg t2
     	or $t3,$0,$0    			#clear reg t3
     	or $t6,$0,$0    			#clear reg t3
     	or $t5,$0,$0 	 			# clear tef t5
       	addi $s2,$zero,1			# put 1 in s2 
	addi $t2,$t2,1   			#add index 1 to t2 pointer on index 1 not 0 
	
#read the file data:
	la $t3, after  				# put address of list into $t3
	lb $t4, 0($t3) 				# get the value from the array cell (number of featers)
	move $s1,$t4   				#number of featers from file
	move $s3,$s1				#store the fist value (number of feature )in s3
	
	
	addi $t9,$t9,1   			#increment number 1 until 5 to print the number of epoch 
##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
     
#Display message of epoch:
	li $v0,4                	        # code call print string message 
   	la $a0, n_ep	 			# message of which epoch we are
   	syscall
   	
   	li $v0,1                 		# code call print string message 
   	move $a0,$t9		 		# number of epoch we want to print evey time
   	syscall
   	
##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
        
   	li $v0,4                 		# code call print string message 
   	la $a0,table_con	 		# message print contents
   	syscall
   	
###########################

power:	
	beq $s3,0,Number_of_line
	mul $s2,$s2,2 				# multiplication s2 to be power 
	subi $s3,$s3,1          		# dec num of featers by 1 for loop
	j power
		
Number_of_line:
	beq $s2,0 ,exit_end			# if file end s2 = number of line
	subi $s2,$s2,1          		# dec num of featers by 1 for loop
	addi $t5,$0,0 	 			# clear tef t5
	la $t3, after  				# put address of list into $t3
	lb $t4, 0($t3) 				# get the value from the array cell (number of featers)
	move $s1,$t4   				# number of featers from file
	sub.s $f10,$f10,$f10 	 		# clear reg f10
	
#### print new lIne & Message 
##print new line
	li $v0, 11				# code to cal print  character 
	li $a0, 10 				# print new line exit (terminate execution)
        syscall
   	## 
## print space
   	li $v0,4          			# code call print string message 
   	la $a0, space	 			# print space tab 
   	syscall
############


calculate:  
#loop to make calculation Y actual 
#loads &compare
	beq  $s1,0 ,y_actual			# if file end
	lb   $t0, after($t2)
	mtc1 $t0, $f5				# move from reg to coproce1
        cvt.s.w $f5, $f5			# move from reg to coproce1 file data
	l.s  $f8, list($t5)			# load from list array wieght
	
## print space & value
   	li $v0,4         			# code call print string message 
   	la $a0, space				# print space tab 
   	syscall
   	
   	li $v0,2                		# code call print string message 
   	add.s $f12,$f5,$f0	 		# content of file data
   	syscall
#########################

## print space & value
   	li $v0,4         		       # code call print string message 
   	la $a0, space	 		       # print space tab 
   	syscall
   	
   	li $v0,2                 	       # code call print string message 
   	add.s $f12,$f8,$f0	 	       # content of file data
   	syscall
#########################
   
#operation
	mul.s $f6,$f8,$f5		      # multipliaction x *w 
	add.s $f10,$f6,$f10		      # summation xw+xw stor in f10

#increment ++
        subi $s1,$s1,1         		     # dec num of featers by 1 for loop
        addi $t2 ,$t2,1			     # for index increment
        addi $t5,$t5,4		             # increment t5 by 4 since it word
        
        j calculate 
        
y_actual:

#sub the content f10 from thr 
	lwc1 $f2,thr			   # load the vlaue of thershold 
	sub.s $f11,$f10,$f2		   # sub the summation from loop calculate with threshold then store in f11
	lwc1 $f29 ,OneFloat		   # load the value 1 in f29
		
#compare the value of sub to be in step function
	c.lt.s $f11,$f0			   # if f11 < f0 set code =1 else code =0
	bc1f Set_One			   # code =0 mean condition flase 
	bc1t Set_Zero			   # code =1 mean condition true 
	
Set_Zero:
	mov.s $f3,$f0			   #sore the value of 0 in f3
	j error				   #jump to calculate error
		
Set_One:
 	mov.s $f3,$f29		           #sore the value of 1 in f3
 	j error				   #jump to calculate error
 	
###################################################

error:
#Calculate the Error 
	lb   $t0, after($t2)
	mtc1 $t0, $f5				# move from reg to coproce1
        cvt.s.w $f5, $f5			#move from reg to coproce1
        sub.s $f4,$f5,$f3			#sub yd(f5) - yac(f3)
	
## print space & value
   	li $v0,4         			 # code call print string message 
   	la $a0, space				 # print space tab 
   	syscall
   	
   	li $v0,2             		        # code call print string message 
   	add.s $f12,$f5,$f0	 		# print y_d
   	syscall
#########################

## print space & value
   	li $v0,4         			# code call print string message 
   	la $a0, space	 			# print space tab 
   	syscall
   	
   	li $v0,2                		 # code call print string message 
   	add.s $f12,$f3,$f0			 # print Y acyual
   	syscall
   	
#########################

 ## print space & value
   	li $v0,4          			# code call print string message 
   	la $a0, space	 			# print space tab 
   	syscall
   	
   	li $v0,2                 		# code call print string message 
   	add.s $f12,$f4,$f0			# print Error
   	syscall
   
###################################################

	or $t5,$0,$0 	 			# clear tef t5
     	addi $t6,$t6,1    			# add index 1 to t2 pointer on index 1 not 0
	la $t7, after 				# put address of list into $t3
	lb $t8, 0($t7) 				# get the value from the array cell (number of featers)
	move $s7,$t8   				# number of featers from file
	lwc1 $f9,le				# load thelearinig rate to reg (f9)
	lwc1 $f13,mom				# load momentum rate to reg (f13)
	
New_Weight:
#Calculate new upadte in weight
# $f3 : Y_actual , $f4: error ,$f5:input ,$f8:weight
#loads & compare

	beq  $s7,0 ,out				#if file end
	lb   $t0, after($t6)
	mtc1 $t0, $f5				# move from reg to coproce1
        cvt.s.w $f5, $f5			#move from reg to coproce1 contain the input	
	l.s  $f8, list($t5)			#load from list array wieght
 
#operations
	mul.s $f14,$f9,$f5			# multipliaction x *learining rate store in f14
	mul.s $f15,$f14,$f4			# multiplication (x*le)*error store in f15
	mul.s $f16,$f13,$f8			# multiplication mom *W_old soter in f16
	add.s $f17,$f16,$f15			# add content of f15 with f16 and store in f17	
	swc1  $f17,list($t5)			# store the new upadte of weight in array of weight list.
	
## print space & value
   	li $v0,4          			# code call print string message 
   	la $a0, space				# print space tab 
   	syscall
   	
	li $v0,2  				#print to check
	add.s $f12,$f17,$f0			#print the new Weight
	syscall
	##
	
#incerement ++
        subi $s7,$s7,1         			 # dec num of featers by 1 for loop
        addi $t6 ,$t6,1				# for index increment
        addi $t5,$t5,4 				# increment t5 by 4 since it word
        j New_Weight 
        

out:
	addi $t2 ,$t2,1				# for index increment
	
## print space & value
   	li $v0,4          			# code call print string message 
   	la $a0, space	 			# print space tab 
   	syscall
   	
	li $v0,2  				# print to check
	add.s $f12,$f9,$f0			# print the learinig rate
	syscall
	##
	
	## print space & value
   	li $v0,4          			# code call print string message 
   	la $a0, space				# print space tab 
   	syscall
   	
	li $v0,2  				# print to check
	add.s $f12,$f13,$f0			# print the momentum
	syscall
	##
	
## print space & value
   	li $v0,4          			# code call print string message 
   	la $a0, space	 			# print space tab 
   	syscall
   	
	li $v0,2  				# print to check
	add.s $f12,$f2,$f0			# print Threshold
	syscall
	##
	j Number_of_line
  
exit_end:
	##
	li $v0, 11
	li $a0, 10 				# print new line
        syscall
        ###

	j Loop_Number_Epoch


###################################################	

error_input_file: 
li $v0,55					# code to call MessageDialog
la $a0,errorfile				# to call print message error
la $a1,1
syscall   
j read_file

###################################################	
End_Programe:	
#**** Exit from program******
li $v0, 10 # exit system call 
syscall  
     
