#!/bin/bash			
#Ben D'crus - 10498343

echo "Hello, "${USER}
echo "This Program can be modified to download pictures off most websites. Use responsibly.  "

while true; do #while loop
	#Variables
	start0='1533'
	end0='2042'

	#Program options
	echo "Enter 1 to Download a specific thumbnail"
	echo "Enter 2 to Download ALL thumbnails"
	echo "Enter 3 to Download images in a range(by last 4 digits of the file name)"
	echo "Enter 4 to Download a specified number of images"
	echo "Enter q to quit"

	#downloads a file of urls, grep by https:secure, then cutting by F2 to format url file, then saved to image.txt.
	wget -q "https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152" -O - | grep '"https://secure'|cut -d\" -f2 > images.txt 
	#Prompts user, saves response as choice.
	read -p 'Please Enter your Choice: ' choice

	if [[ $choice == '1' ]]; then #Choice 1
		while true; do #While True Loop
			#Asks user for input			
			read -p "Please enter last 4 digits: " digits
				#If input is less than or greater than parameters, then reprompt till it is.
				if [[ $digits -lt "$start0" ]] || [[ $digits -gt "end0" ]] ; then
					echo "Must be between 1533 & 2042"
		
				else
					#Else continue with the rest of the strings	
					#Echo info
					echo "Downloading DSC0$digits, with the file name DSC0$digits.jpg..File Download Complete. "
					#grep images file looking for specified digits, save to new txt file.
					grep  $digits images.txt > specific_image.txt
					#download specified images to image file
					wget -q -c -i specific_image.txt -P specific_image/
					break
				fi
		done 

	elif [[ $choice == '2' ]]; then #Choice 2
		# echos text
		echo "All Images Downloading..."
		#Downloads images from url file, q to download quietly, c to check for files, p to save to new folder
		wget -q -nc -i  images.txt -P all_images/
		#Echo confirmation 
		echo "All Images Downloaded to File" 
		

	elif [[ $choice == '3' ]]; then #Choice 3

		while true; do #While True Loop
			#Prompts user to enter value, saves as start.
			read -p "Enter last 4 digits of the Starting File Name (Between DSC01533 to DSC02042): " start
				#If start is less than start0, then..
				if [[ $start -lt $start0 ]]; then
					#Echo.. prompts for re-enter
					echo "Must be between 1533 & 2042"
				else
					break #Break out of loop
				fi
		done 		
		
		while true; do	#While True loop (Had to make 2 loops for "choice3" so it wouldnt make user re-enter starting value if previously accepted)
			#prompts user to enter value, saves as End.
			read -p "Enter last 4 digits of the Ending File Name (Between DSC01533 to DSC02042): " end
				#If end is greater than end0, then..
				if [[ $end -gt $end0 ]]; then
					#Echo. Then reprompts user to re-enter
					echo "Must be between 1533 & 2042"
				else
					#For loop. This assigns the start and end variable of what user enters as the range.
					for i in $(seq $start $end); do
						#Downloads requested range URLs to range.txt file			
						grep  -a  $i images.txt >> range.txt
					done
					#Downloads pictures from range.txt file to range_images file
					wget -q -c -i range.txt -P range_images
					echo "Images Downloaded to File. "
					break
				fi	
		done # break out of loop	
	
	elif [[ $choice == '4' ]]; then #Choice 4
		#Prompts user for value, saves as uchoice
		read -p "Enter Amount of Images to Download: " random_image
		#Shuf "shuffles/randomizes" pictures, sending to uchoice.txt file
		shuf -n $random_image images.txt > random_image.txt
		#Downloads URLs from uchoice.txt to random_images file
		wget -q -c -i random_image.txt -P random_images
		echo "Images downloaded to File. "

	elif [[ $choice == 'q' ]]; then #Enter Q to quit
		#Echo String
		echo "Your Free-trial is over" ${USER}, "Please Pay to to keep using this program. "
		break
	else #Re-prompts user to enter one of the valid options.
		echo 'Invalid. Please choose again. '	
	fi
done