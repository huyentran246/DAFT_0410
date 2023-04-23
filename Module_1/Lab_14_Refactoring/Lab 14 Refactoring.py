#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import random
import re

#************************ Functions 

#Function to Randomise color combination AM-12
# input : a dictionary with colors like : { 1 char key : color name }  {"g": "Green", "b": "Blue"}
# output : a list of 4 elements with a random choices of key colors like : ['w', 'g', 'w', 'p']
def RandomiseColor(L_Color_dictionary):
    random.seed()  #initialise the random sequence
    Color_list = list(Color_dictionary.keys())  # we make a list of all color keys
    return random.choices(Color_list, k = 4)    # we choose 4 elements in this list

#Function to get a color code from letter
# input : an letter in (k,g,b,w,y,r,p)
# output : a colorised string like ''\033[1;30;1;4mk\033[0m' for k
def GetColorCode(L_char):
    MyStr = '\033[1;'
    if L_char == 'w':
        MyStr = MyStr + '37'
    elif L_char == 'k':
        MyStr = MyStr + '30'
    elif L_char == 'g':
        MyStr = MyStr + '32'
    elif L_char == 'b':
        MyStr = MyStr + '34'
    elif L_char == 'y':
        MyStr = MyStr + '93'
    elif L_char == 'r':
        MyStr = MyStr + '31'
    elif L_char == 'p':
        MyStr = MyStr + '35'
    MyStr = MyStr + ';1;4m' + L_char + '\033[0m'
    return MyStr
    

#Function to display all combinaison the user played
# input : a list of list of 4 elements with a user choices of key colors and scores like : ['w', 'g', 'w', 'p',2,1]
# output : just print output
def DisplayUserConbinations(L_user_combination):
    for i in range(0,len(L_user_combination)):
        Lign = '|' + GetColorCode(L_user_combination[i][0]) + '|' + GetColorCode(L_user_combination[i][1]) + '|' + GetColorCode(L_user_combination[i][2])
        Lign = Lign + '|' + GetColorCode(L_user_combination[i][3]) + '|-|' + str(L_user_combination[i][4]) + '|' + str(L_user_combination[i][5]) + '|'
        print(Lign)
    


#Function to Ask the user for a combination AM-14
# input : a dictionary with colors like : { 1 char key : color name }  {"g": "Green", "b": "Blue"}
# output : a list of 4 elements with a random choices of key colors like : ['w', 'g', 'w', 'p']
def inputCombination(L_Color_dictionary):
    
    #local variables initialisation
    L_input_valid = False
    L_question = 'Please enter a suite of 4 colors (k,g,b,w,y,r,p or ? for help) \n' 
    L_help = """"
    Please enter a suite of 4 colors;
    Use ‘k' for Black ; ‘g’ for Green ; ‘b' for Blue ; ‘w’ for White ; ‘y’ for Yellow ; 'r’ for Red ; 'p’ for Pink
    For exemple : type gbwy and press enter for Green-Blue-White-Yellow
    """
    
    #Loop untill input_valid
    while L_input_valid == False:
        # display help at first turn
        if G_count_turns == 0:
            print(L_help)
        MyStr = input(L_question)
        MyStr = str(MyStr)
        MyStr = MyStr.lower()
        
        # display help when input is '?'
        if MyStr == '?' and not G_count_turns == 0:
            print(L_help)
            continue
        if MyStr == 'marcopolo':   #che@t m0de
            print(G_computer_combination)
            continue
        
        #Test the validity of the input ,  G_user_combination
        pattern = '[kgbwyrp]{4}'  #lets use RegEx
        if (re.findall(pattern, MyStr) != []):
            if len(MyStr)==4:
                L_input_valid = True
        if L_input_valid == False:
            print('The input was not reconized, Please enter a correct suite of 4 colors')
    
    #output
    return list(MyStr)

#Function to  Test the combination and build answer AM-15
# input : the two list to compare like : ['w', 'g', 'w', 'p'] 
# output : a tuple (nb good elements, nb missplaced, answer_string)
def TestCombination(L_user_combination, L_computer_combination):
    
    #local variables initialisation
    L_good = 0
    L_miss_placed = 0
    
    #Count the number of good placed
    for i in range(0,4):
        if L_computer_combination[i] == L_user_combination[i]:
            L_good += 1

    #Count the number of misplaced elements
    L_user_combination2 =  L_user_combination.copy() #i make a copy to not modify original list (iterable are ByRef)
    for i in L_computer_combination:
        if i in L_user_combination2:
            L_miss_placed += 1
            L_user_combination2.remove(i)  #remove the element to avoid finding it again
    L_miss_placed = L_miss_placed - L_good  #the good's one are also counted       

    #Build an answer
    if L_good != 0 or L_miss_placed != 0:
        L_answer = '\nYou have ' + str(L_good) + ' elements at the right place\n'
        L_answer = L_answer + 'You have ' + str(L_miss_placed) + ' elements at the wrong place\n'
    else:
        L_answer = 'No elements are present\n'
        
    L_answer = L_answer + 'And you have ' +  str(11 -  G_count_turns) + ' turns left\n' 
    #when displaying this message,G_count_turns is +1   
    
    return (L_good, L_miss_placed, L_answer)
    

#******************* Main program    
# Welcome message AM-11

print("Hey welcome to IronMastermind !!")


# Main Loop start
G_anothergame = True
while G_anothergame:
    #Variable Initialisation AM-13
    G_PlayerScore = (0,0,'')   #the score of the player (nb good,nb misplaced)
    G_count_turns = 0
    G_user_combination = []
    Color_dictionary = {"g": "Green", "b": "Blue", "w": "White", "k": "Black", "y": "Yellow", "r": "Red", "p": "Pink"}

    # Randomise color combination AM-12
    G_computer_combination = RandomiseColor(Color_dictionary)


    
    while G_PlayerScore[0] < 4:

        # Ask the user for a combination AM-14
        G_user_combination.append(inputCombination(Color_dictionary))

        # Test the combination and build answer AM-15
        G_PlayerScore = TestCombination(G_user_combination[G_count_turns], G_computer_combination)
        #adding score to user aswer
        G_user_combination[G_count_turns].append(G_PlayerScore[0])
        G_user_combination[G_count_turns].append(G_PlayerScore[1])
        G_count_turns += 1

        #Display answer AM-16
        print(G_PlayerScore[2])

        DisplayUserConbinations(G_user_combination)
        if G_count_turns == 12: #End game
            break

    #End game
    if G_PlayerScore[0] == 4:
        # Display win message AM-17
        print("\nBravo ! you master my mind !!")
    else:
        # Display lose message AM-18
        print("Oh no, no more try left! You lost. The solution was: ",G_computer_combination)
    MyStr= input('Another game ? y/n ')
    G_anothergame = MyStr == 'y'


# In[ ]:




