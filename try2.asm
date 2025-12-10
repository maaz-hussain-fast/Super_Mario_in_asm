; Maaz Hussain | Super Mario Console Game | Main Code File
; All Rights Reserved
; 08 - 12 - 2025
; 01 : 42 AM

;SIGNING OFF!



INCLUDE Irvine32.inc
INCLUDELIB winmm.lib

PlaySoundA PROTO,
    pszSound:PTR BYTE, 
    hmod:DWORD, 
    fdwSound:DWORD


; ================= CONSTANTS =================
ROW_SIZE = 122    
NUM_ROWS = 30
MAP_SIZE = 3660   

; --- MARIO DIMENSIONS ---
MARIO_WIDTH  = 3
MARIO_HEIGHT = 2 

; --- HUD CONSTANTS ---
HUD_HEIGHT   = 3  

.data

; ================= MENU DATA =================
titleRow1 BYTE " XXX  X X  XXX  XXX  XXX     X   X   X   XXX  X  XXX     XXX  XXX   XXX    XXX ",0
titleRow2 BYTE "X     X X  X X  X    X X     XX XX  X X  X X  X  X X     X X  X X  X   X  X    ",0
titleRow3 BYTE " XXX  X X  XXX  XXX  RR      X X X  XXX  RR   X  X X     XXX  RR   X   X   XXX ",0
titleRow4 BYTE "   X  X X  X    X    X X     X   X  X X  X X  X  X X     X X  X X  X   X     X ",0
titleRow5 BYTE "XXX   XXX  X    XXX  X X     X   X  X X  X X  X  XXX     XXX  X X   XXX   XXX ",0

instRow1 BYTE "XXX XXXX XXX XXX XXX X X XXX XXX XXX  XXX  XXXX   XXX",0
instRow2 BYTE " X  X  X X    X  X X X X X    X   X   X X  X  X  X  ",0
instRow3 BYTE " X  X  X XXX  X  XX  X X X    X   X   X X  X  X   XXX",0
instRow4 BYTE " X  X  X   X  X  X X X X X    X   X   X X  X  X     X",0
instRow5 BYTE "XXX X  X XXX  X  X X XXX XXX  X  XXX  XXX  X  X  XXX",0

leadRow1 BYTE "X   XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX",0
leadRow2 BYTE "X   X   X X X X X   X X X X X X X X X X X X",0
leadRow3 BYTE "X   XXX XXX X X XXX RR  XXX X X XXX RR  X X",0
leadRow4 BYTE "X   X   X X X X X   X X X X X X X X X X X X",0
leadRow5 BYTE "XXX XXX X X XX  XXX X X XXX XXX X X X X XX ",0

pauseRow1 BYTE "XXX  XXX  X X  XXX  XXX  XXX",0
pauseRow2 BYTE "X X  X X  X X  X    X    X X",0
pauseRow3 BYTE "XXX  XXX  X X  XXX  XXX  X X",0
pauseRow4 BYTE "X    X X  X X    X  X    X X",0
pauseRow5 BYTE "X    X X  XXX  XXX  XXX  XX ",0

; ================= END SCREEN DATA =================
goRow1 BYTE " XXX   XXX  X   X  XXX     XXX  X   X  XXX  XXX ",0
goRow2 BYTE "X      X X  XX XX  X       X X  X   X  X    X X ",0
goRow3 BYTE "X XX   XXX  X X X  XXX     X X  X   X  XXX  RR  ",0
goRow4 BYTE "X  X   X X  X   X  X       X X   X X   X    X X ",0
goRow5 BYTE " XXX   X X  X   X  XXX     XXX    X    XXX  X X ",0

lvlRow1 BYTE "X    XXX  X  X  XXX  X    ",0
lvlRow2 BYTE "X    X    X  X  X    X    ",0
lvlRow3 BYTE "X    XXX  X  X  XXX  X    ",0
lvlRow4 BYTE "X    X     XX   X    X    ",0
lvlRow5 BYTE "XXX  XXX   XX   XXX  XXX  ",0

compRow1 BYTE " XXX  XXX  X  X  XXX  X    XXX  XXXXX  XXX  XXX",0
compRow2 BYTE "X     X X  XXXX  X X  X    X      X    X    X X ",0
compRow3 BYTE "X     X X  X  X  PPP  X    XXX    X    XXX  X X ",0
compRow4 BYTE "X     X X  X  X  X    X    X      X    X    X X ",0
compRow5 BYTE " XXX  XXX  X  X  X    XXX  XXX    X    XXX  XX",0


; ================= PRINCESS SAVED DATA =================
prinRow1 BYTE "XXX  XXX  XXX  X  X  XXX  XXX  XXX  XXX",0
prinRow2 BYTE "X X  X X   X   XX X  X    X    X    X  ",0
prinRow3 BYTE "XXX  XXX   X   X XX  X    XXX  XXX  XXX",0
prinRow4 BYTE "X    X X   X   X  X  X    X      X    X",0
prinRow5 BYTE "X    X X  XXX  X  X  XXX  XXX  XXX  XXX",0

savedRow1 BYTE "  XXXX  XXX  X   X  XXX  XXX",0
savedRow2 BYTE " X      X X  X   X  X    X X",0
savedRow3 BYTE " XXX    XXX  X   X  XXX  X X",0
savedRow4 BYTE "    X   X X   X X   X    X X",0
savedRow5 BYTE "XXXX    X X    X    XXX  XX ",0





; ================= TEXT STRINGS =================

rollNum  BYTE "- 24i-0708 | A Maaz Hussain Production -",0

; --- SOUND CONSTANTS & FILES ---
SND_ASYNC    EQU 1h
SND_LOOP     EQU 8h
SND_FILENAME EQU 20000h
SND_PURGE    EQU 40h

fileMenuBG   BYTE "mainmenu_bg.wav",0
fileLevelBG  BYTE "lvl_1_bg.wav",0
fileCoin     BYTE "coin.wav",0
fileJump     BYTE "jump.wav",0
fileGameOver BYTE "game_over.wav",0
filePause    BYTE "pause.wav",0
fileVictory  BYTE "victory.wav",0
fileConnector BYTE "connector.wav",0
fileEnemyDie BYTE "explode.wav",0
fileBossDie  BYTE "explosion.wav",0

menuOpt1 BYTE "Start Game",0
menuOpt2 BYTE "Instructions",0
menuOpt3 BYTE "Leaderboard",0
menuOpt4 BYTE "Exit Game",0

pauseOpt1 BYTE "Resume Game",0
pauseOpt2 BYTE "Main Menu",0

txtCtrl  BYTE "--- CONTROLS ---",0
txtW     BYTE "W  : Jump",0
txtA     BYTE "A  : Move Left",0
txtD     BYTE "D  : Move Right",0
txtX     BYTE "X  : Back to Menu",0  
txtP     BYTE "P  : Pause Game",0

txtGoal  BYTE "--- GOALS ---",0
txtG1    BYTE "Jump over bricks to pass level",0
txtG2    BYTE "Collect coins to gain score (1 coin = 10 score)",0

msgLead  BYTE "--- HIGH SCORES ---",0
msgWait  BYTE "Press any key to return...",0
msgErr   BYTE "Error: level file missing/wrong size!",0
msgSave  BYTE "Saving Score to Leaderboard...",0
msgSaved BYTE "Saved! Returning to Menu...",0
msgLevel BYTE "Level 1 Complete!",0
msgName  BYTE "Enter Your Name: ",0
msgDie   BYTE "YOU DIED!",0
strFinalScore BYTE "FINAL SCORE: ",0 

; ================= GAME DATA =================
file1    BYTE "level1.txt",0
file2    BYTE "level1_part2.txt",0
file3    BYTE "level2.txt",0       
file4    BYTE "level2_part2.txt",0   
currentFilePtr DWORD ?  
isGhostMode  BYTE  0     ; 0 = Normal, 1 = Ghost Mode

fileHandle DWORD ?
mapBuffer BYTE MAP_SIZE + 100 DUP(?) 
bytesRead DWORD ?

strScore BYTE "SCORE:",0
score DWORD 0

; --- POWERUP VARIABLES ---
isPowerUp      BYTE 0   ; 0 = Normal, 1 = Powered Up
powerUpTimer   BYTE 0   
powerUpTick    BYTE 0   

strLives BYTE "LIVES:",0 
lives BYTE 3               

strCoins BYTE "COINS:",0
coins    BYTE 0

strLevelLabel BYTE "LEVEL:",0

strTime  BYTE "TIME:",0
timeMin  BYTE 0
timeSec  BYTE 0
timeTick BYTE 0    

xPos BYTE 5 
yPos BYTE 8  

; --- MAGNET DATA (Safe loop vars) ---
magnetL DWORD ?
magnetR DWORD ?
magnetT DWORD ?
magnetB DWORD ?


; --- ENEMY DATA ---
enemyX BYTE 0
enemyY BYTE 0
enemyDir BYTE 1  ; 1 = Right, 0 = Left
enemyAlive BYTE 0 ; 0 = Dead/None, 1 = Alive
gameOverFlag BYTE 0 


; --- BOSS DATA ---
bossX BYTE 0
bossY BYTE 0
bossAlive BYTE 0     ; 1 = Alive
fireX BYTE 0
fireY BYTE 0
fireActive BYTE 0    ; 0 = Ready, 1 = Flying
fireTimer BYTE 0     
BOSS_RADAR = 25      

; --- FILE HANDLING DATA ---
leaderFile BYTE "leaderboard.txt",0
leadBuffer BYTE 5000 DUP(?)
outputLine BYTE 100 DUP(?)  
playerName BYTE 20 DUP(?)   
nameLen    DWORD ?
currentRank DWORD 1
colIndex    BYTE 0 

headerRank BYTE "RANK",0
headerName BYTE "NAME",0
headerScore BYTE "SCORE",0
headerTime BYTE "TIME",0


; --- Menu Variables ---
titleColor BYTE 10    
menuTimer  BYTE 0      
currentSelection BYTE 0 
pauseSelection BYTE 0

; --- Physics Variables ---
isJumping BYTE 0       
jumpCounter BYTE 0     
JUMP_HEIGHT = 4        
canDoubleJump BYTE 1  

; --- Level Management ---
currentStage BYTE 0    

.code
main PROC


MainMenu:

        INVOKE PlaySoundA, NULL, NULL, SND_PURGE 
        
        ; Start Menu Music
        INVOKE PlaySoundA, OFFSET fileMenuBG, NULL, SND_ASYNC OR SND_LOOP OR SND_FILENAME    
    
        mov eax, white + (black * 16)
        call SetTextColor
        call Clrscr
        call DrawStaticFrame
        call DrawFullTitle
        call DrawMenuOptions

    MenuLoop:
        mov eax, 50
        call Delay
        call ReadKey
        jnz HandleMenuInput

        inc menuTimer
        cmp menuTimer, 20
        jl MenuLoop          

        mov menuTimer, 0
        inc titleColor
        cmp titleColor, 15
        jbe RedrawTitle
        mov titleColor, 9   

    RedrawTitle:
        call DrawFullTitle
        call DrawMenuOptions 
        jmp MenuLoop

    HandleMenuInput:
        cmp al, 'w'
        je MoveUp
        cmp al, 'W'
        je MoveUp
        cmp al, 's'
        je MoveDown
        cmp al, 'S'
        je MoveDown
        cmp al, 13 ; Enter Key
        je SelectOption
        jmp MenuLoop

    MoveUp:
        cmp currentSelection, 0
        je WrapBottom
        dec currentSelection
        jmp UpdateMenuUI

    WrapBottom:
        mov currentSelection, 3
        jmp UpdateMenuUI

    MoveDown:
        cmp currentSelection, 3
        je WrapTop
        inc currentSelection
        jmp UpdateMenuUI

    WrapTop:
        mov currentSelection, 0
        jmp UpdateMenuUI

    UpdateMenuUI:
        call DrawMenuOptions
        jmp MenuLoop

    SelectOption:
        cmp currentSelection, 0
        je StartNewGame
        cmp currentSelection, 1
        je Instructions
        cmp currentSelection, 2
        je Leaderboard
        cmp currentSelection, 3
        je ExitProgram
        jmp MenuLoop

    StartNewGame:
        call InputPlayerName 
        jmp PreGameSetup

    Instructions:
        mov eax, white + (black * 16)
        call SetTextColor
        call Clrscr
        call DrawStaticFrame 
        call DrawInstTitle
        
        mov eax, white + (black * 16)
        call SetTextColor
        mov dl, 52
        mov dh, 11
        call Gotoxy
        mov edx, OFFSET txtCtrl
        call WriteString
        mov dl, 54
        mov dh, 13
        call Gotoxy
        mov edx, OFFSET txtW
        call WriteString
        mov dl, 54
        mov dh, 14
        call Gotoxy
        mov edx, OFFSET txtA
        call WriteString
        mov dl, 54
        mov dh, 15
        call Gotoxy
        mov edx, OFFSET txtD
        call WriteString
        mov dl, 54
        mov dh, 16
        call Gotoxy
        mov edx, OFFSET txtX
        call WriteString
        mov dl, 54
        mov dh, 17
        call Gotoxy
        mov edx, OFFSET txtP
        call WriteString
        mov dl, 53
        mov dh, 20       
        call Gotoxy
        mov edx, OFFSET txtGoal
        call WriteString      
        mov dl, 45       
        mov dh, 22       
        call Gotoxy
        mov edx, OFFSET txtG1
        call WriteString
        mov dl, 36       
        mov dh, 23       
        call Gotoxy
        mov edx, OFFSET txtG2
        call WriteString
        mov dl, 47
        mov dh, 26       
        call Gotoxy
        mov edx, OFFSET msgWait
        call WriteString
        call ReadChar
        jmp MainMenu

    Leaderboard:
        call ShowLeaderboardScreen
        jmp MainMenu

    ExitProgram:
        exit

    ; ================= GAME SETUP =================

    PreGameSetup:
        mov eax, white + (black * 16)
        call SetTextColor
        call Clrscr
        
        mov score, 0
        mov lives, 3        
        mov coins, 0        
        mov currentStage, 0
        mov timeMin, 0
        mov timeSec, 0
        mov timeTick, 0
        mov gameOverFlag, 0 
        
        mov currentFilePtr, OFFSET file1
        
        call LoadMapFromFile
        cmp eax, INVALID_HANDLE_VALUE
        je FileError
        call AddFrameToMap
        call DrawMap
        call DrawHUDBackground
        call DrawPlayer

        INVOKE PlaySoundA, OFFSET fileLevelBG, NULL, SND_ASYNC OR SND_LOOP OR SND_FILENAME

        jmp GameLoop


    FileError:
        mov edx, OFFSET msgErr
        call WriteString
        call ReadChar
        jmp MainMenu

    ; ================= GAME LOOP =================

    GameLoop:
        mov eax, 50
        call Delay

        ; --- Check for Game Over Signal ---
        cmp gameOverFlag, 1
        je HandleGameOverJump
        cmp gameOverFlag, 2
        je HandleLevelCompleteJump
        cmp gameOverFlag, 3         
        je HandleInterimLevelJump   

        ; --- UPDATE HUD STATS ---
        mov eax, white + (blue * 16) 
        call SetTextColor
        
        ; 1. SCORE
        mov dl, 2
        mov dh, 1
        call Gotoxy
        mov edx, OFFSET strScore
        call WriteString
        mov al, ' '
        call WriteChar
        mov eax, score
        call WriteDec
        
        ; 2. LIVES
        mov dl, 25
        mov dh, 1
        call Gotoxy
        mov edx, OFFSET strLives
        call WriteString
        mov al, ' '
        call WriteChar
        movzx eax, lives
        call WriteDec

        ; 3. COINS
        mov dl, 55
        mov dh, 1
        call Gotoxy
        mov eax, yellow + (blue * 16) 
        call SetTextColor
        mov edx, OFFSET strCoins
        call WriteString
        mov al, ' '
        call WriteChar
        movzx eax, coins
        call WriteDec
        
        mov eax, white + (blue * 16)
        call SetTextColor

        ; 4. LEVEL
        mov dl, 80
        mov dh, 1
        call Gotoxy
        mov edx, OFFSET strLevelLabel
        call WriteString
        mov al, ' '
        call WriteChar
        
        
        movzx eax, currentStage
        shr eax, 1     
        inc eax       
        call WriteDec

        ; 5. TIMER
        mov dl, 105
        mov dh, 1
        call Gotoxy
        mov edx, OFFSET strTime
        call WriteString
        mov al, ' '
        call WriteChar
        
        movzx eax, timeMin
        cmp eax, 10
        jae NoPadMin
        push eax
        mov al, '0'
        call WriteChar
        pop eax

    NoPadMin:
        movzx eax, timeMin
        call WriteDec
        
        mov al, ':'
        call WriteChar
        
        movzx eax, timeSec
        cmp eax, 10
        jae NoPadSec
        push eax
        mov al, '0'
        call WriteChar
        pop eax

    NoPadSec:
        movzx eax, timeSec
        call WriteDec

        ; --- TIMER LOGIC ---
        inc timeTick
        cmp timeTick, 20    
        jl SkipTimerUpdate
        
        mov timeTick, 0
        inc timeSec
        cmp timeSec, 60
        jl SkipTimerUpdate
        
        mov timeSec, 0
        inc timeMin
    
    SkipTimerUpdate:

        ; ================= POWERUP TIMER =================
        cmp isPowerUp, 1
        jne SkipPowerUpLogic
        
        inc powerUpTick
        cmp powerUpTick, 20  
        jl SkipPowerUpLogic
        
        mov powerUpTick, 0
        dec powerUpTimer
        cmp powerUpTimer, 0
        jg SkipPowerUpLogic
        
        ; Time ran out
        mov isPowerUp, 0
        call DrawPlayer      
        
    SkipPowerUpLogic:

        call ReadKey

        
        jz NoInput

        cmp al, 'g'       
        je ToggleGhost
        cmp al, 'G'       
        je ToggleGhost


        cmp al, "p"
        je PauseGame
        cmp al, "P"
        je PauseGame
        cmp al, "x"
        je MainMenu
        cmp al, "a"
        je MoveLeft
        cmp al, "d"
        je MoveRight
        cmp al, "w"
        je StartJump
        
        NoInput:
        call UpdatePhysics
        call UpdateEnemy
        call UpdateBossAndFireball  
        jmp GameLoop

    HandleGameOverJump:
        call HandleGameOverScreen
        jmp MainMenu

    HandleLevelCompleteJump:
        call HandleLevelCompleteScreen
        jmp MainMenu


    HandleInterimLevelJump:

        call HandleLevelCompleteScreen
        
        mov gameOverFlag, 0        
        mov currentStage, 2        
        mov currentFilePtr, OFFSET file3 
        
        mov eax, white + (black * 16)
        call SetTextColor
        call Clrscr               
        
        call LoadMapFromFile      
        call AddFrameToMap        
        call DrawMap             
        call DrawHUDBackground    
        
        ; Reset Player Position
        mov xPos, 5               
        call DrawPlayer           
        
        ; Restart Background Music

        INVOKE PlaySoundA, OFFSET fileLevelBG, NULL, SND_ASYNC OR SND_LOOP OR SND_FILENAME
        
        jmp GameLoop


    ; ================= PAUSE LOGIC =================
    PauseGame:

    INVOKE PlaySoundA, OFFSET filePause, NULL, SND_ASYNC OR SND_LOOP OR SND_FILENAME

        ; --- SMOOTH PAUSE ---
        mov eax, black + (black * 16)
        call SetTextColor
        
        mov dh, 1 
        mov ecx, 28 
    
    ClearGameAreaLoop:
        push ecx
        mov dl, 0
        call Gotoxy
        mov ecx, 120
        ClearRowLoop:
            mov al, ' '
            call WriteChar
            loop ClearRowLoop
        inc dh
        pop ecx
        loop ClearGameAreaLoop

        call DrawStaticFrame    
        call DrawPauseTitle
        mov pauseSelection, 0
        call DrawPauseOptions

    PauseLoop:
        mov eax, 50
        call Delay
        call ReadKey
        jz PauseLoop

        cmp al, 'w'
        je P_Up
        cmp al, 'W'
        je P_Up
        cmp al, 's'
        je P_Down
        cmp al, 'S'
        je P_Down
        cmp al, 13
        je P_Select
        jmp PauseLoop

    P_Up:
        mov pauseSelection, 0
        call DrawPauseOptions
        jmp PauseLoop
    P_Down:
        mov pauseSelection, 1
        call DrawPauseOptions
        jmp PauseLoop
    
    P_Select:
        cmp pauseSelection, 0
        je ResumeGame
        cmp pauseSelection, 1
        je QuitToMenu
        jmp PauseLoop

    ResumeGame:
        call Clrscr
        call DrawMap
        call DrawHUDBackground 
        call DrawPlayer
        INVOKE PlaySoundA, OFFSET fileLevelBG, NULL, SND_ASYNC OR SND_LOOP OR SND_FILENAME
        jmp GameLoop

    QuitToMenu:
        call SaveScoreToFile 
        jmp MainMenu


    ToggleGhost:
        
        xor isGhostMode, 1    ; Switches mode ON/OFF
        call DrawPlayer       
        jmp GameLoop          

    ; ================= MOVEMENT =================
    MoveLeft:
        call CheckCollisionLeft
        cmp al, 1
        je GameLoop
        call UpdatePlayerOldPos
        dec xPos
        call CheckForCoins  
        call DrawPlayer     
        jmp GameLoop

    MoveRight:
        cmp xPos, 115   
        jge CheckLevelTransition

        call CheckCollisionRight
        cmp al, 1
        je GameLoop
        call UpdatePlayerOldPos
        inc xPos
        call CheckForCoins  
        call DrawPlayer     
        jmp GameLoop

    CheckLevelTransition:
        
        cmp currentStage, 0
        je LoadStage1
        
        cmp currentStage, 1
        je TriggerLevel1Complete
        
        cmp currentStage, 2
        je LoadStage3
        
        jmp FinishLevel         

    LoadStage1:
        mov currentFilePtr, OFFSET file2
        jmp CommonLoadNext

    LoadStage3:
        mov currentFilePtr, OFFSET file4
        jmp CommonLoadNext
        
    TriggerLevel1Complete:

        mov gameOverFlag, 3 
        jmp GameLoop

    CommonLoadNext:
        ; --- PLAY CONNECTOR SOUND (SYNC) ---
        INVOKE PlaySoundA, OFFSET fileConnector, NULL, SND_FILENAME
        
        inc currentStage
        
        mov eax, white + (black * 16)
        call SetTextColor
        
        call Clrscr
        call LoadMapFromFile
        call AddFrameToMap
        call DrawMap
        call DrawHUDBackground 
        mov xPos, 5
        call DrawPlayer
        jmp GameLoop

    FinishLevel:
        mov gameOverFlag, 2
        jmp GameLoop

    StartJump:
        call CheckGround
        cmp al, 1         
        je DoJump            
        
        cmp canDoubleJump, 1
        jne GameLoop        
        
        mov canDoubleJump, 0 
        jmp DoJump

    DoJump:

    INVOKE PlaySoundA, OFFSET fileJump, NULL, SND_ASYNC OR SND_FILENAME
        mov isJumping, 1
        mov jumpCounter, JUMP_HEIGHT
        jmp GameLoop

main ENDP

; ================= PROCEDURES =================

HandleGameOverScreen PROC

INVOKE PlaySoundA, OFFSET fileGameOver, NULL, SND_ASYNC OR SND_FILENAME
    mov eax, white + (black * 16)
    call SetTextColor
    call Clrscr
    call DrawStaticFrame
    
    ; Draw GAME OVER (Red)
    mov dl, 37  
    mov dh, 6
    call Gotoxy
    mov esi, OFFSET goRow1
    call DrawRedTitleRow
    mov dl, 37
    inc dh
    call Gotoxy
    mov esi, OFFSET goRow2
    call DrawRedTitleRow
    mov dl, 37
    inc dh
    call Gotoxy
    mov esi, OFFSET goRow3
    call DrawRedTitleRow
    mov dl, 37
    inc dh
    call Gotoxy
    mov esi, OFFSET goRow4
    call DrawRedTitleRow
    mov dl, 37
    inc dh
    call Gotoxy
    mov esi, OFFSET goRow5
    call DrawRedTitleRow

    ; Score & Msg
    mov eax, white + (black * 16)
    call SetTextColor
    
    mov dl, 50
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET strFinalScore
    call WriteString
    mov eax, score
    call WriteDec

    mov dl, 45
    mov dh, 17
    call Gotoxy
    mov edx, OFFSET msgSaved
    call WriteString
    
    call SaveScoreToFile
    
    mov eax, 3000
    call Delay
    ret
HandleGameOverScreen ENDP

HandleLevelCompleteScreen PROC
    add score, 1000       

    INVOKE PlaySoundA, OFFSET fileVictory, NULL, SND_ASYNC OR SND_FILENAME
    
    mov eax, white + (black * 16)
    call SetTextColor
    call Clrscr
    call DrawStaticFrame
    
    cmp gameOverFlag, 2
    je DrawPrincessMsg

    mov dl, 45
    mov dh, 4
    call Gotoxy
    mov esi, OFFSET lvlRow1
    call DrawGreenTitleRow
    mov dl, 45
    inc dh
    call Gotoxy
    mov esi, OFFSET lvlRow2
    call DrawGreenTitleRow
    mov dl, 45
    inc dh
    call Gotoxy
    mov esi, OFFSET lvlRow3
    call DrawGreenTitleRow
    mov dl, 45
    inc dh
    call Gotoxy
    mov esi, OFFSET lvlRow4
    call DrawGreenTitleRow
    mov dl, 45
    inc dh
    call Gotoxy
    mov esi, OFFSET lvlRow5
    call DrawGreenTitleRow

    ; DRAW "COMPLETED"
    mov dl, 37
    mov dh, 10
    call Gotoxy
    mov esi, OFFSET compRow1
    call DrawGreenTitleRow
    mov dl, 37
    inc dh
    call Gotoxy
    mov esi, OFFSET compRow2
    call DrawGreenTitleRow
    mov dl, 37
    inc dh
    call Gotoxy
    mov esi, OFFSET compRow3
    call DrawGreenTitleRow
    mov dl, 37
    inc dh
    call Gotoxy
    mov esi, OFFSET compRow4
    call DrawGreenTitleRow
    mov dl, 37
    inc dh
    call Gotoxy
    mov esi, OFFSET compRow5
    call DrawGreenTitleRow
    
    jmp FinishScreen

DrawPrincessMsg:
    call PlayFireworksAnimation

    
    mov dl, 35         
    mov dh, 4
    call Gotoxy
    mov esi, OFFSET prinRow1
    call DrawGreenTitleRow
    mov dl, 35
    inc dh
    call Gotoxy
    mov esi, OFFSET prinRow2
    call DrawGreenTitleRow
    mov dl, 35
    inc dh
    call Gotoxy
    mov esi, OFFSET prinRow3
    call DrawGreenTitleRow
    mov dl, 35
    inc dh
    call Gotoxy
    mov esi, OFFSET prinRow4
    call DrawGreenTitleRow
    mov dl, 35
    inc dh
    call Gotoxy
    mov esi, OFFSET prinRow5
    call DrawGreenTitleRow

    ; DRAW "SAVED"
    mov dl, 45          
    mov dh, 10
    call Gotoxy
    mov esi, OFFSET savedRow1
    call DrawGreenTitleRow
    mov dl, 45
    inc dh
    call Gotoxy
    mov esi, OFFSET savedRow2
    call DrawGreenTitleRow
    mov dl, 45
    inc dh
    call Gotoxy
    mov esi, OFFSET savedRow3
    call DrawGreenTitleRow
    mov dl, 45
    inc dh
    call Gotoxy
    mov esi, OFFSET savedRow4
    call DrawGreenTitleRow
    mov dl, 45
    inc dh
    call Gotoxy
    mov esi, OFFSET savedRow5
    call DrawGreenTitleRow

FinishScreen:
   
    call SaveScoreToFile
    
    
    mov eax, 3000
    call Delay
    ret
HandleLevelCompleteScreen ENDP

DrawRedTitleRow PROC
    RowLoop:
        mov al, [esi]
        cmp al, 0
        je RowEnd
        cmp al, 'X'
        je RedBlock
        cmp al, 'R'
        je RedBlock
        mov eax, black + (black * 16)
        call SetTextColor
        mov al, ' '
        call WriteChar
        jmp NextC
    RedBlock:
        mov eax, lightRed + (black * 16)
        call SetTextColor
        mov al, 0DBh
        call WriteChar
    NextC:
        inc esi
        jmp RowLoop
    RowEnd:
    ret
DrawRedTitleRow ENDP

DrawGreenTitleRow PROC
    RowLoop:
        mov al, [esi]
        cmp al, 0
        je RowEnd
        cmp al, 'X'
        je GreenBlock
        cmp al, 'P'
        je GreenBlock
        mov eax, black + (black * 16)
        call SetTextColor
        mov al, ' '
        call WriteChar
        jmp NextC
    GreenBlock:
        mov eax, lightGreen + (black * 16)
        call SetTextColor
        mov al, 0DBh
        call WriteChar
    NextC:
        inc esi
        jmp RowLoop
    RowEnd:
    ret
DrawGreenTitleRow ENDP

; --- ENEMY LOGIC ---
UpdateEnemy PROC
    cmp enemyAlive, 1
    jne EndUpdateEnemy
    
    mov ecx, 2 ; Height
    mov dh, enemyY
    EraseEnemyOuter:
        mov dl, enemyX
        call Gotoxy
        push ecx
        
        cmp currentStage, 2
        jae EraseEnemyBlack
        
        ; Level 1 (Blue)
        mov eax, lightBlue + (black * 16)
        call SetTextColor
        mov al, 0DBh
        jmp DoEraseEnemy
        
    EraseEnemyBlack:
        ; Level 2 (Black)
        mov eax, black + (black * 16)
        call SetTextColor
        mov al, ' '
        
    DoEraseEnemy:
        call WriteChar
        pop ecx
        inc dh
        loop EraseEnemyOuter

    cmp enemyDir, 1
    je MoveEnemyRight
    
    ; Move Left
    movzx eax, enemyY
    mov ebx, ROW_SIZE
    mul ebx
    movzx ecx, enemyX
    dec ecx         
    add eax, ecx
    mov bl, mapBuffer[eax] 
    
    cmp bl, 'B'
    je FlipRight
    cmp bl, 'F'
    je FlipRight
    cmp bl, 'W'    
    je FlipRight
    
    dec enemyX
    jmp DrawEnemyLabel

MoveEnemyRight:
    movzx eax, enemyY
    mov ebx, ROW_SIZE
    mul ebx
    movzx ecx, enemyX
    inc ecx         
    add eax, ecx
    mov bl, mapBuffer[eax]
    
    cmp bl, 'B'
    je FlipLeft
    cmp bl, 'F'
    je FlipLeft
    cmp bl, 'W'    
    je FlipLeft
    
    inc enemyX
    jmp DrawEnemyLabel

FlipRight:
    mov enemyDir, 1
    jmp DrawEnemyLabel
FlipLeft:
    mov enemyDir, 0
    
DrawEnemyLabel:
    call DrawEnemy
    call CheckMarioEnemyCollision
    
EndUpdateEnemy:
    ret
UpdateEnemy ENDP

DrawEnemy PROC
    mov dl, enemyX
    mov dh, enemyY
    call Gotoxy
    
    mov eax, lightRed + (black * 16) 
    call SetTextColor
    mov al, 0DBh
    call WriteChar
    
    mov dl, enemyX
    inc dh
    call Gotoxy
    
    mov eax, green + (black * 16)
    call SetTextColor
    mov al, 0DBh
    call WriteChar
    
    ret
DrawEnemy ENDP

CheckMarioEnemyCollision PROC
    mov al, xPos
    add al, 3
    cmp al, enemyX
    jle NoCollision 
    
    mov al, enemyX
    add al, 1   
    cmp al, xPos
    jle NoCollision 
    
    ; Check Y
    mov al, yPos
    add al, 2
    cmp al, enemyY
    jle NoCollision 
    
    mov al, enemyY
    add al, 2   
    cmp al, yPos
    jle NoCollision 
    
    ; --- COLLISION DETECTED ---
    cmp isGhostMode, 1      
    je NoCollision          

    ; Stomp Check:
    mov al, yPos
    add al, 2
    mov bl, enemyY
    inc bl      
    cmp al, bl
    jle IsStomp
    
    dec lives
    cmp lives, 0
    je TriggerGameOver  
    
    call UpdatePlayerOldPos
    mov xPos, 5
    call DrawPlayer
    ret

IsStomp:
    ; Kill Enemy
    mov enemyAlive, 0
    call UpdatePlayerOldPos 
    call DrawPlayer
    
    push eax  
    INVOKE PlaySoundA, OFFSET fileEnemyDie, NULL, SND_ASYNC
    pop eax

    add score, 100      
    
    ret

TriggerGameOver:
    mov gameOverFlag, 1 
    ret

NoCollision:
    ret
CheckMarioEnemyCollision ENDP

DrawHUDBackground PROC
    mov eax, white + (blue * 16)
    call SetTextColor
    
    mov dl, 1
    mov dh, 1
    call Gotoxy
    mov ecx, 118 
    DrawRow1:
        mov al, ' '
        call WriteChar
        loop DrawRow1
        
    ret
DrawHUDBackground ENDP

InputPlayerName PROC
    mov eax, white + (black * 16)
    call SetTextColor
    call Clrscr
    call DrawStaticFrame
    mov dl, 40
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET msgName
    call WriteString
    
    mov edx, OFFSET playerName
    mov ecx, 19 
    call ReadString
    mov nameLen, eax
    ret
InputPlayerName ENDP

ShowLeaderboardScreen PROC
    mov eax, white + (black * 16)
    call SetTextColor
    call Clrscr
    call DrawStaticFrame 
    call DrawLeadTitle

    mov eax, white + (black * 16)
    call SetTextColor
    
    mov dh, 10
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET headerRank
    call WriteString
    
    mov dh, 10      
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET headerName
    call WriteString
    
    mov dh, 10      
    mov dl, 75
    call Gotoxy
    mov edx, OFFSET headerScore
    call WriteString
    
    mov dh, 10      
    mov dl, 95
    call Gotoxy
    mov edx, OFFSET headerTime
    call WriteString
    
    mov dl, 28
    mov dh, 11
    call Gotoxy
    mov ecx, 75

DrawLine:
    mov al, '-'
    call WriteChar
    loop DrawLine

    mov edx, OFFSET leaderFile
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je LeadEnd 
    
    mov fileHandle, eax
    mov edx, OFFSET leadBuffer
    mov ecx, 5000
    call ReadFromFile
    mov bytesRead, eax
    mov eax, fileHandle
    call CloseFile
    
    mov esi, OFFSET leadBuffer
    add esi, bytesRead
    mov BYTE PTR [esi], 0
    
    mov esi, OFFSET leadBuffer
    mov dh, 12          
    mov colIndex, 0     

    mov dl, 30          
    call Gotoxy

ParseLoop:
    mov al, [esi]
    cmp al, 0
    je LeadEnd
    
    cmp al, 9           
    je HandleTab
    cmp al, 13          
    je HandleNewline
    cmp al, 10          
    je SkipChar
    
    call WriteChar
    jmp NextChar

HandleTab:
    inc colIndex
    cmp colIndex, 1
    je JumpToName
    cmp colIndex, 2
    je JumpToScore
    cmp colIndex, 3
    je JumpToTime
    jmp NextChar 

JumpToName:
    mov dl, 45
    call Gotoxy
    jmp NextChar
JumpToScore:
    mov dl, 75
    call Gotoxy
    jmp NextChar
JumpToTime:
    mov dl, 95
    call Gotoxy
    jmp NextChar

HandleNewline:
    mov colIndex, 0     
    inc dh              
    mov dl, 30          
    call Gotoxy
    jmp NextChar

SkipChar:
    jmp NextChar

NextChar:
    inc esi
    jmp ParseLoop
    
LeadEnd:
    mov dl, 45
    mov dh, 28
    call Gotoxy
    mov edx, OFFSET msgWait
    call WriteString
    call ReadChar
    ret
ShowLeaderboardScreen ENDP

SaveScoreToFile PROC
    mov eax, white + (black * 16)
    call SetTextColor
    
    mov currentRank, 1
    mov edx, OFFSET leaderFile
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je BuildOutputString 
    
    mov fileHandle, eax
    mov edx, OFFSET leadBuffer
    mov ecx, 4900
    call ReadFromFile
    mov bytesRead, eax
    mov eax, fileHandle
    call CloseFile
    
    mov ecx, bytesRead
    mov esi, OFFSET leadBuffer
    cmp ecx, 0
    je BuildOutputString

CountRankLoop:
    cmp byte ptr [esi], 10 
    jne NextByteRank
    inc currentRank
NextByteRank:
    inc esi
    loop CountRankLoop
    
BuildOutputString:
    mov edi, OFFSET outputLine
    
    ; Rank
    mov eax, currentRank
    call IntToBuffer
    mov al, 9 ; Tab
    stosb
    
    mov esi, OFFSET playerName
    mov ecx, nameLen
    rep movsb
    
    mov al, 9 
    stosb
    
    mov eax, score
    call IntToBuffer
    mov al, 9 
    stosb
    
    movzx eax, timeMin
    cmp eax, 10
    jae TimeMinNoPad
    push eax
    mov al, '0'
    stosb
    pop eax

TimeMinNoPad:
    call IntToBuffer
    mov al, ':'
    stosb
    movzx eax, timeSec
    cmp eax, 10
    jae TimeSecNoPad
    push eax
    mov al, '0'
    stosb
    pop eax

TimeSecNoPad:
    call IntToBuffer
    
    mov al, 13 
    stosb
    mov al, 10 
    stosb
    mov al, 0  
    stosb
    
    mov edx, OFFSET leaderFile
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je CreateNewFile
    
    mov fileHandle, eax
    mov edx, OFFSET leadBuffer
    mov ecx, 4900
    call ReadFromFile
    mov bytesRead, eax
    mov eax, fileHandle
    call CloseFile
    
    mov edx, OFFSET leaderFile
    call CreateOutputFile
    mov fileHandle, eax
    
    mov edx, OFFSET leadBuffer
    mov ecx, bytesRead
    call WriteToFile
    jmp WriteNewScore 

CreateNewFile:
    mov edx, OFFSET leaderFile
    call CreateOutputFile
    mov fileHandle, eax
    
WriteNewScore:
    mov edi, OFFSET outputLine
    mov ecx, 0
LenLoop:
    cmp BYTE PTR [edi], 0
    je LenDone
    inc ecx
    inc edi
    jmp LenLoop
LenDone:
    
    mov edx, OFFSET outputLine
    
    mov eax, fileHandle  
    
    call WriteToFile
    
    mov eax, fileHandle
    call CloseFile

EndSave:
    ret
SaveScoreToFile ENDP

IntToBuffer PROC
    push ebx
    push ecx
    push edx
    mov ecx, 0 
    mov ebx, 10
    test eax, eax   
    jnz DivLoop
    mov al, '0'
    mov [edi], al
    inc edi
    jmp PopEnd
DivLoop:
    mov edx, 0
    div ebx
    push edx 
    inc ecx
    test eax, eax
    jnz DivLoop
PopLoop:
    pop eax
    add al, '0'
    mov [edi], al
    inc edi
    loop PopLoop
PopEnd:
    pop edx
    pop ecx
    pop ebx
    ret
IntToBuffer ENDP

CheckForCoins PROC
    pushad              
    
    cmp yPos, 3
    jl SetStartYZero
    movzx eax, yPos
    sub eax, 3     
    cmp eax, HUD_HEIGHT
    jge SetStartY
    mov eax, HUD_HEIGHT
    jmp SetStartY
SetStartYZero:
    mov eax, HUD_HEIGHT
SetStartY:
    mov ebx, eax    
    
    movzx eax, yPos
    add eax, 5      
    cmp eax, 29
    jle SetEndY
    mov eax, 29
SetEndY:
    mov ecx, eax    
    
    cmp xPos, 3
    jl SetStartXZero
    movzx eax, xPos
    sub eax, 3      
    jmp SetStartX
SetStartXZero:
    mov eax, 0
SetStartX:
    mov edx, eax    
    
    movzx eax, xPos
    add eax, 6    
    cmp eax, 119
    jle SetEndX
    mov eax, 119
SetEndX:
    mov esi, eax    
    
    mov edi, edx   

MagnetRowLoop:
    cmp ebx, ecx    
    jg EndCoinCheck
    
    push eax        
    push edx
    mov edx, 0
    mov eax, ebx    
    push ebx        
    mov ebx, ROW_SIZE
    mul ebx         
    pop ebx         
    pop edx
    push eax        
    
    mov edx, edi   
    
MagnetColLoop:
    cmp edx, esi    
    jg NextMagnetRow
    
    mov eax, [esp]  
    add eax, edx    
    
    mov cl, mapBuffer[eax]
    
    cmp cl, 'o'
    je FoundCoin
    
    cmp cl, '+'
    je FoundPowerUp
    
    jmp NotCoinMagnet
    
FoundCoin:
    inc coins
    pushad
    INVOKE PlaySoundA, OFFSET fileCoin, NULL, SND_ASYNC OR SND_FILENAME
    popad
    add score, 300      
    jmp RemoveItem

FoundPowerUp:
    mov isPowerUp, 1
    mov powerUpTimer, 15  
    mov powerUpTick, 0
    
    pushad
    INVOKE PlaySoundA, OFFSET fileJump, NULL, SND_ASYNC OR SND_FILENAME
    popad
    jmp RemoveItem

RemoveItem:
    mov mapBuffer[eax], '.' 
    
    ; --- VISUAL REMOVAL ---
    push eax
    push edx
    push ecx
    push edx 
    
    mov eax, ebx
    mov dh, al ; Row
    mov eax, edx
    mov dl, al ; Col
    call Gotoxy
    
    cmp currentStage, 2
    jae EraseCoinBlack
    
    ; Level 1 (Light Blue)
    mov eax, lightBlue + (black * 16)
    call SetTextColor
    mov al, 0DBh 
    jmp DoEraseCoin

    EraseCoinBlack:
    mov eax, black + (black * 16)
    call SetTextColor
    mov al, ' '  
    
    DoEraseCoin:
    call WriteChar
    
    pop edx
    pop ecx
    pop edx
    pop eax
    
    
NotCoinMagnet:
    inc edx
    jmp MagnetColLoop
    
NextMagnetRow:
    pop eax         
    pop eax         
    inc ebx         
    jmp MagnetRowLoop

EndCoinCheck:
    popad
    ret
CheckForCoins ENDP

DrawPauseTitle PROC
    mov dl, 47
    mov dh, 5
    call Gotoxy
    mov esi, OFFSET pauseRow1
    call DrawPauseTitleRow
    mov dl, 47
    mov dh, 6
    call Gotoxy
    mov esi, OFFSET pauseRow2
    call DrawPauseTitleRow
    mov dl, 47
    mov dh, 7
    call Gotoxy
    mov esi, OFFSET pauseRow3
    call DrawPauseTitleRow
    mov dl, 47
    mov dh, 8
    call Gotoxy
    mov esi, OFFSET pauseRow4
    call DrawPauseTitleRow
    mov dl, 47
    mov dh, 9
    call Gotoxy
    mov esi, OFFSET pauseRow5
    call DrawPauseTitleRow
    ret
DrawPauseTitle ENDP

DrawPauseTitleRow PROC
    P_RowLoop:
        mov al, [esi]
        cmp al, 0
        je P_RowEnd
        cmp al, 'X'
        je P_RedBlock
        mov eax, black + (black * 16)
        call SetTextColor
        mov al, ' '
        call WriteChar
        jmp P_Next
    P_RedBlock:
        mov eax, lightRed + (black * 16)
        call SetTextColor
        mov al, 0DBh
        call WriteChar
    P_Next:
        inc esi
        jmp P_RowLoop
    P_RowEnd:
    ret
DrawPauseTitleRow ENDP

DrawPauseOptions PROC
    mov dl, 52
    mov dh, 14
    call Gotoxy
    cmp pauseSelection, 0
    je P_High1
    mov eax, white + (black * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    jmp P_Print1
P_High1:
    mov eax, white + (red * 16)
    call SetTextColor
    mov al, '>'
    call WriteChar
    mov al, ' '
    call WriteChar
P_Print1:
    mov edx, OFFSET pauseOpt1
    call WriteString
    mov dl, 52
    mov dh, 16
    call Gotoxy
    cmp pauseSelection, 1
    je P_High2
    mov eax, white + (black * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    jmp P_Print2
P_High2:
    mov eax, white + (red * 16)
    call SetTextColor
    mov al, '>'
    call WriteChar
    mov al, ' '
    call WriteChar
P_Print2:
    mov edx, OFFSET pauseOpt2
    call WriteString
    mov eax, white + (black * 16)
    call SetTextColor
    ret
DrawPauseOptions ENDP

DrawStaticFrame PROC
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dl, 0
    mov dh, 0
    call Gotoxy
    mov ecx, 120
DrawTop:
    mov al, 0DBh
    call WriteChar
    loop DrawTop
    mov dl, 0
    mov dh, 29
    call Gotoxy
    mov ecx, 120
DrawBot:
    mov al, 0DBh
    call WriteChar
    loop DrawBot
    mov ecx, 30
    mov dh, 0
DrawLeft:
    mov dl, 0
    call Gotoxy
    mov al, 0DBh
    call WriteChar
    inc dh
    loop DrawLeft
    mov ecx, 30
    mov dh, 0
DrawRight:
    mov dl, 119
    call Gotoxy
    mov al, 0DBh
    call WriteChar
    inc dh
    loop DrawRight
    ret
DrawStaticFrame ENDP

AddFrameToMap PROC
    mov ecx, 120         
    mov esi, 0           
FrameTopLoop:
    mov mapBuffer[esi], 'F'
    inc esi
    loop FrameTopLoop
    mov ecx, 120
    mov esi, 3538
FrameBotLoop:
    mov mapBuffer[esi], 'F'
    inc esi
    loop FrameBotLoop
    mov ecx, 30          
    mov esi, 0
FrameLeftLoop:
    mov mapBuffer[esi], 'F'
    add esi, ROW_SIZE   
    loop FrameLeftLoop
    mov ecx, 30
    mov esi, 119
FrameRightLoop:
    mov mapBuffer[esi], 'F'
    add esi, ROW_SIZE
    loop FrameRightLoop
    ret
AddFrameToMap ENDP

DrawMenuOptions PROC
    mov dl, 52
    mov dh, 13
    call Gotoxy
    cmp currentSelection, 0
    je Highlight1
    mov eax, white + (black * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    jmp PrintOpt1
Highlight1:
    mov eax, white + (red * 16)
    call SetTextColor
    mov al, '>'
    call WriteChar
    mov al, ' '
    call WriteChar
PrintOpt1:
    mov edx, OFFSET menuOpt1
    call WriteString
    mov dl, 52
    mov dh, 15
    call Gotoxy
    cmp currentSelection, 1
    je Highlight2
    mov eax, white + (black * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    jmp PrintOpt2
Highlight2:
    mov eax, white + (red * 16)
    call SetTextColor
    mov al, '>'
    call WriteChar
    mov al, ' '
    call WriteChar
PrintOpt2:
    mov edx, OFFSET menuOpt2
    call WriteString
    mov dl, 52
    mov dh, 17
    call Gotoxy
    cmp currentSelection, 2
    je Highlight3
    mov eax, white + (black * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    jmp PrintOpt3
Highlight3:
    mov eax, white + (red * 16)
    call SetTextColor
    mov al, '>'
    call WriteChar
    mov al, ' '
    call WriteChar
PrintOpt3:
    mov edx, OFFSET menuOpt3
    call WriteString
    mov dl, 52
    mov dh, 19
    call Gotoxy
    cmp currentSelection, 3
    je Highlight4
    mov eax, white + (black * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    jmp PrintOpt4
Highlight4:
    mov eax, white + (red * 16)
    call SetTextColor
    mov al, '>'
    call WriteChar
    mov al, ' '
    call WriteChar
PrintOpt4:
    mov edx, OFFSET menuOpt4
    call WriteString
    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 43
    mov dh, 26
    call Gotoxy
    mov edx, OFFSET rollNum
    call WriteString
    ret
DrawMenuOptions ENDP

DrawFullTitle PROC
    mov dl, 20
    mov dh, 3
    call Gotoxy
    mov esi, OFFSET titleRow1
    call DrawTitleRow
    mov dl, 20
    mov dh, 4
    call Gotoxy
    mov esi, OFFSET titleRow2
    call DrawTitleRow
    mov dl, 20
    mov dh, 5
    call Gotoxy
    mov esi, OFFSET titleRow3
    call DrawTitleRow
    mov dl, 20
    mov dh, 6
    call Gotoxy
    mov esi, OFFSET titleRow4
    call DrawTitleRow
    mov dl, 20
    mov dh, 7
    call Gotoxy
    mov esi, OFFSET titleRow5
    call DrawTitleRow
    ret
DrawFullTitle ENDP

DrawTitleRow PROC
    DrawTitleLoop:
        mov al, [esi]
        cmp al, 0
        je EndTitleRow
        cmp al, 'X'
        je PrintColorBlock
        cmp al, 'R'
        je PrintColorBlock
        mov eax, black + (black * 16)
        call SetTextColor
        mov al, ' '
        call WriteChar
        jmp NextTitleChar
    PrintColorBlock:
        movzx eax, titleColor
        add eax, (black * 16)
        call SetTextColor
        mov al, 0DBh     
        call WriteChar
    NextTitleChar:
        inc esi
        jmp DrawTitleLoop
    EndTitleRow:
    ret
DrawTitleRow ENDP

DrawInstTitle PROC
    mov dl, 33
    mov dh, 3
    call Gotoxy
    mov esi, OFFSET instRow1
    call DrawInstRow
    mov dl, 33
    mov dh, 4
    call Gotoxy
    mov esi, OFFSET instRow2
    call DrawInstRow
    mov dl, 33
    mov dh, 5
    call Gotoxy
    mov esi, OFFSET instRow3
    call DrawInstRow
    mov dl, 33
    mov dh, 6
    call Gotoxy
    mov esi, OFFSET instRow4
    call DrawInstRow
    mov dl, 33
    mov dh, 7
    call Gotoxy
    mov esi, OFFSET instRow5
    call DrawInstRow
    ret
DrawInstTitle ENDP

DrawInstRow PROC
    DrawInstLoop:
        mov al, [esi]
        cmp al, 0
        je EndInstRow
        cmp al, 'X'
        je PrintBlueBlock
        cmp al, 'R'
        je PrintBlueBlock
        mov eax, black + (black * 16)
        call SetTextColor
        mov al, ' '
        call WriteChar
        jmp NextInstChar
    PrintBlueBlock:
        mov eax, lightBlue + (black * 16)
        call SetTextColor
        mov al, 0DBh     
        call WriteChar
    NextInstChar:
        inc esi
        jmp DrawInstLoop
    EndInstRow:
    ret
DrawInstRow ENDP

DrawLeadTitle PROC
    mov dl, 38
    mov dh, 3
    call Gotoxy
    mov esi, OFFSET leadRow1
    call DrawInstRow 
    mov dl, 38
    mov dh, 4
    call Gotoxy
    mov esi, OFFSET leadRow2
    call DrawInstRow
    mov dl, 38
    mov dh, 5
    call Gotoxy
    mov esi, OFFSET leadRow3
    call DrawInstRow
    mov dl, 38
    mov dh, 6
    call Gotoxy
    mov esi, OFFSET leadRow4
    call DrawInstRow
    mov dl, 38
    mov dh, 7
    call Gotoxy
    mov esi, OFFSET leadRow5
    call DrawInstRow
    ret
DrawLeadTitle ENDP

UpdatePhysics PROC
    cmp isJumping, 1
    je HandleJumpUp
    call CheckGround
    cmp al, 1
    je OnGround
    call UpdatePlayerOldPos
    inc yPos
    call DrawPlayer
    call CheckForCoins  
    ret


    HandleJumpUp:

        call CheckCeiling
        cmp al, 1
        je StopJump
        call UpdatePlayerOldPos
        dec yPos
        call DrawPlayer
        call CheckForCoins 
        dec jumpCounter
        cmp jumpCounter, 0
        jg RetPhysics
        StopJump:
        mov isJumping, 0
        ret


    OnGround:

    mov isJumping, 0
    mov canDoubleJump, 1 
    ret
    RetPhysics:
    call CheckLavaDeath
    ret

UpdatePhysics ENDP

CheckLavaDeath PROC

    movzx eax, yPos
    add eax, 2           
    mov ebx, ROW_SIZE
    mul ebx             
    movzx ecx, xPos     
    add eax, ecx        
    
    ; Check Left Foot
    mov bl, mapBuffer[eax]
    cmp bl, 'L'
    je KillMarioLava
    
    ; Check Right Foot
    inc eax
    mov bl, mapBuffer[eax]
    cmp bl, 'L'
    je KillMarioLava
    
    ret

KillMarioLava:

    call UpdatePlayerOldPos 

    dec lives
    cmp lives, 0
    je TriggerGameOverLava
    
    push eax
    INVOKE PlaySoundA, OFFSET fileJump, NULL, SND_ASYNC OR SND_FILENAME
    pop eax

    ;  RESET Coordinates
    mov xPos, 5
    mov yPos, 8
    
    ; DRAW at new position
    call DrawPlayer
    
    mov eax, 500
    call Delay
    
    ret

TriggerGameOverLava:

    mov gameOverFlag, 1
    ret

CheckLavaDeath ENDP

CheckGround PROC

    movzx eax, yPos
    add eax, 2            
    cmp eax, NUM_ROWS
    jge IsSolidG          
    mov ebx, ROW_SIZE
    mul ebx              
    movzx ecx, xPos      
    mov edx, eax
    add edx, ecx
    
    cmp yPos, HUD_HEIGHT
    jl IsSolidG

    
    mov bl, mapBuffer[edx]
    cmp bl, 'G'
    je IsSolidG
    cmp bl, 'B'
    je IsSolidG
    cmp bl, 'S'
    je IsSolidG
    cmp bl, 'F'
    je IsSolidG
    cmp bl, 'W'    
    je IsSolidG

    ; --- CHECK 2 (Center Foot) ---
    inc edx
    mov bl, mapBuffer[edx]
    cmp bl, 'G'
    je IsSolidG
    cmp bl, 'B'
    je IsSolidG
    cmp bl, 'S'
    je IsSolidG
    cmp bl, 'F'
    je IsSolidG
    cmp bl, 'W'    
    je IsSolidG    

    ; --- CHECK 3 (Right Foot) ---
    inc edx
    mov bl, mapBuffer[edx]
    cmp bl, 'G'
    je IsSolidG
    cmp bl, 'B'
    je IsSolidG
    cmp bl, 'S'
    je IsSolidG
    cmp bl, 'F'
    je IsSolidG
    cmp bl, 'W'    
    je IsSolidG

    mov al, 0
    ret
    IsSolidG:
    mov al, 1
    ret
CheckGround ENDP

CheckCeiling PROC
    cmp yPos, HUD_HEIGHT 
    jle IsSolidC
    cmp yPos, 0
    je IsSolidC           
    movzx eax, yPos
    dec eax               
    mov ebx, ROW_SIZE
    mul ebx
    movzx ecx, xPos
    mov edx, eax
    add edx, ecx

    ; --- CHECK 1 (Left Head) ---
    mov bl, mapBuffer[edx]
    cmp bl, 'B'
    je TryBreakC1
    cmp bl, 'W'
    je TryBreakC1
    cmp bl, 'G'
    je IsSolidC
    cmp bl, 'S'
    je IsSolidC
    cmp bl, 'F'
    je IsSolidC
    jmp CheckC2
    
TryBreakC1:
    mov eax, edx 
    call AttemptDestroyBlock
    cmp al, 1
    je IsSolidC
    ; If destroyed, continue to Check 2

CheckC2:
    ; --- CHECK 2 (Center Head) ---
    inc edx
    mov bl, mapBuffer[edx]
    cmp bl, 'B'
    je TryBreakC2
    cmp bl, 'W'
    je TryBreakC2
    cmp bl, 'G'
    je IsSolidC
    cmp bl, 'S'
    je IsSolidC
    cmp bl, 'F'
    je IsSolidC
    jmp CheckC3

TryBreakC2:
    mov eax, edx
    call AttemptDestroyBlock
    cmp al, 1
    je IsSolidC

CheckC3:
    ; --- CHECK 3 (Right Head) ---
    inc edx
    mov bl, mapBuffer[edx]
    cmp bl, 'B'
    je TryBreakC3
    cmp bl, 'W'
    je TryBreakC3
    cmp bl, 'G'
    je IsSolidC
    cmp bl, 'S'
    je IsSolidC
    cmp bl, 'F'
    je IsSolidC
    jmp NotSolidC

TryBreakC3:
    mov eax, edx
    call AttemptDestroyBlock
    cmp al, 1
    je IsSolidC

NotSolidC:
    mov al, 0
    ret
IsSolidC:
    mov al, 1
    ret
CheckCeiling ENDP

CheckCollisionLeft PROC
    cmp xPos, 0
    je IsSolidL
    movzx eax, yPos      
    mov ebx, ROW_SIZE
    mul ebx
    movzx ecx, xPos
    dec ecx               
    add eax, ecx        
    
    ; --- CHECK 1 (Top Shoulder) ---
    mov bl, mapBuffer[eax]
    cmp bl, 'W'
    je CheckDestroyL_1
    cmp bl, 'B'
    je CheckDestroyL_1
    cmp bl, 'G'
    je IsSolidL
    cmp bl, 'S'
    je IsSolidL
    cmp bl, 'F'
    je IsSolidL
    jmp CheckBottomL

CheckDestroyL_1:
    call AttemptDestroyBlock
    cmp al, 0
    je CheckBottomL
    jmp IsSolidL

CheckBottomL:
    ; --- CHECK 2 (Bottom Leg) ---
    add eax, ROW_SIZE
    mov bl, mapBuffer[eax]
    cmp bl, 'W'
    je CheckDestroyL_2
    cmp bl, 'B'
    je CheckDestroyL_2
    cmp bl, 'G'
    je IsSolidL
    cmp bl, 'S'
    je IsSolidL
    cmp bl, 'F'
    je IsSolidL
    jmp NotSolidL

CheckDestroyL_2:
    call AttemptDestroyBlock
    cmp al, 0
    je NotSolidL
    jmp IsSolidL

NotSolidL:
    mov al, 0
    ret
IsSolidL:
    mov al, 1
    ret
CheckCollisionLeft ENDP

CheckCollisionRight PROC
    cmp xPos, 115        
    jge IsSolidR
    movzx eax, yPos
    mov ebx, ROW_SIZE
    mul ebx
    movzx ecx, xPos
    add ecx, 3            
    add eax, ecx
    
    ; --- CHECK 1 (Top Shoulder) ---
    mov bl, mapBuffer[eax]
    cmp bl, 'W'
    je CheckDestroyR_1
    cmp bl, 'B'
    je CheckDestroyR_1
    cmp bl, 'G'
    je IsSolidR
    cmp bl, 'S'
    je IsSolidR
    cmp bl, 'F'
    je IsSolidR
    jmp CheckBottomR

CheckDestroyR_1:
    call AttemptDestroyBlock
    cmp al, 0
    je CheckBottomR ; If destroyed, check bottom leg
    jmp IsSolidR    ; If not destroyed, stop

CheckBottomR:
    ; --- CHECK 2 (Bottom Leg) ---
    add eax, ROW_SIZE
    mov bl, mapBuffer[eax]
    cmp bl, 'W'
    je CheckDestroyR_2
    cmp bl, 'B'
    je CheckDestroyR_2
    cmp bl, 'G'
    je IsSolidR
    cmp bl, 'S'
    je IsSolidR
    cmp bl, 'F'
    je IsSolidR
    jmp NotSolidR

CheckDestroyR_2:
    call AttemptDestroyBlock
    cmp al, 0
    je NotSolidR
    jmp IsSolidR

NotSolidR:
    mov al, 0
    ret
IsSolidR:
    mov al, 1
    ret
CheckCollisionRight ENDP


LoadMapFromFile PROC
    mov edx, currentFilePtr
    call OpenInputFile
    mov fileHandle, eax
    cmp eax, INVALID_HANDLE_VALUE
    je LoadFail
    mov edx, OFFSET mapBuffer
    mov ecx, MAP_SIZE
    call ReadFromFile
    mov bytesRead, eax
    mov mapBuffer[eax], 0
    mov eax, fileHandle
    call CloseFile

    ; --- 1. FIND MARIO ('M') ---
    mov ecx, MAP_SIZE
    mov esi, 0
    FindMarioLoop:
        cmp mapBuffer[esi], 'M'
        jne NextChar
        mov eax, esi
        mov bl, ROW_SIZE
        div bl
        mov yPos, al
        mov xPos, ah
        mov mapBuffer[esi], '.' 
        dec yPos  
        jmp FinishMario
    NextChar:
        inc esi
        loop FindMarioLoop
    FinishMario:

    ; --- 2. FIND NORMAL ENEMY ('E') ---
    mov ecx, MAP_SIZE
    mov esi, 0
    mov enemyAlive, 0 
    FindEnemyLoop:
        cmp mapBuffer[esi], 'E'
        jne NextEnemyChar
        
        mov eax, esi
        mov bl, ROW_SIZE
        div bl
        mov enemyY, al
        mov enemyX, ah
        mov enemyAlive, 1
        mov enemyDir, 1 
        mov mapBuffer[esi], '.' 
        inc enemyY 
        jmp FinishEnemy
    NextEnemyChar:
        inc esi
        loop FindEnemyLoop
    FinishEnemy:

    ; --- 3. FIND BOSS ('K') --- 
    mov ecx, MAP_SIZE
    mov esi, 0
    mov bossAlive, 0
    
    FindBossLoop:
        cmp mapBuffer[esi], 'K'
        jne NextBossChar
        
        ; Found Boss
        mov eax, esi
        mov bl, ROW_SIZE
        div bl
        mov bossY, al
        mov bossX, ah
        
        mov bossAlive, 1
        mov fireActive, 0 
        
        mov mapBuffer[esi], '.' 
        
        dec bossY 
        
        jmp FinishBoss
    NextBossChar:
        inc esi
        loop FindBossLoop

    FinishBoss:
    LoadFail:
    ret
LoadMapFromFile ENDP

DrawBoss PROC
    cmp bossAlive, 1
    jne SkipDrawBoss
    cmp currentStage, 3  
    jne SkipDrawBoss

    mov dl, bossX
    mov dh, bossY
    call Gotoxy
    mov eax, lightRed + (black * 16) 
    call SetTextColor
    mov al, 0DBh
    call WriteChar
    
    mov eax, yellow + (black * 16)   
    call SetTextColor
    mov al, 'O'
    call WriteChar
    
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov al, 0DBh
    call WriteChar

    mov dl, bossX
    dec dl       
    inc dh
    call Gotoxy
    
    mov eax, green + (black * 16)
    call SetTextColor
    mov al, 0DBh
    call WriteChar
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov al, 0DBh
    call WriteChar
    call WriteChar
    call WriteChar
    mov eax, green + (black * 16)
    call SetTextColor
    mov al, 0DBh
    call WriteChar

    mov dl, bossX
    inc dh
    call Gotoxy
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov al, 0DBh
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 0DBh
    call WriteChar

SkipDrawBoss:
    ; --- Draw Fireball ---
    cmp fireActive, 1
    jne EndBossDraw
    
    mov dl, fireX
    mov dh, fireY
    call Gotoxy
    mov eax, yellow + (lightRed * 16) 
    call SetTextColor
    mov al, 'O'                       
    call WriteChar
    
EndBossDraw:
    ret
DrawBoss ENDP

UpdateBossAndFireball PROC
    cmp bossAlive, 1
    jne RetBossLogic
    cmp currentStage, 3     
    jne RetBossLogic

    call DrawBoss           
    
    call CheckMarioBossCollision
    cmp bossAlive, 0        
    je RetBossLogic

    cmp fireActive, 1
    jne CheckRadar

    inc fireTimer
    cmp fireTimer, 1      
    jl CheckRadar
    mov fireTimer, 0

    ; 1. Erase Old Fireball
    mov dl, fireX
    mov dh, fireY
    call Gotoxy
    mov eax, black + (black * 16) 
    call SetTextColor
    mov al, ' '
    call WriteChar

    ; 2. Move Left (Towards Mario)
    dec fireX

    ; 3. Check Wall Collision 
    movzx eax, fireY
    mov ebx, ROW_SIZE
    mul ebx
    movzx ecx, fireX
    add eax, ecx
    mov bl, mapBuffer[eax]
    
    cmp bl, 'W'
    je KillFireball
    cmp bl, 'F'
    je KillFireball
    cmp bl, 'L' 
    je KillFireball

    ; 4. Check Mario Collision
    mov al, xPos
    cmp fireX, al
    jl NoHit
    add al, 3       
    cmp fireX, al
    jg NoHit

    mov al, yPos
    cmp fireY, al
    jl NoHit
    add al, 3       
    cmp fireY, al
    jg NoHit

    ; --- HIT MARIO ---
    dec lives
    cmp lives, 0
    je BossKillsMarioGameover
    
    ; Respawn Mario 
    call UpdatePlayerOldPos
    mov xPos, 5             
    mov yPos, 24            
    call DrawPlayer
    
    INVOKE PlaySoundA, OFFSET fileGameOver, NULL, SND_ASYNC OR SND_FILENAME
    jmp KillFireball        

BossKillsMarioGameover:
    mov gameOverFlag, 1
    ret

NoHit:
    jmp RetBossLogic        

KillFireball:
    mov fireActive, 0
    jmp RetBossLogic

    ; ================= RADAR LOGIC (AI) =================
CheckRadar:
    cmp fireActive, 1       
    je RetBossLogic

    ; 1. CHECK DIRECTION (Left to Right Only)
    mov al, xPos
    cmp al, bossX
    jge RetBossLogic        

    ; 2. CHECK DISTANCE (5 Blocks = approx 20-25 chars)
    mov al, bossX
    sub al, xPos
    cmp al, 25              
    jg RetBossLogic         

    ; 3. CHECK ALIGNMENT
    mov al, yPos
    sub al, bossY
    jns PosDiff
    neg al
    PosDiff:
    cmp al, 5               
    jg RetBossLogic

    INVOKE PlaySoundA, OFFSET fileConnector, NULL, SND_ASYNC 
    mov fireActive, 1
    mov al, bossX
    sub al, 2               
    mov fireX, al           
    mov al, bossY
    mov fireY, al           
    
RetBossLogic:
    ret
UpdateBossAndFireball ENDP

DrawMap PROC
    mov dl, 0
    mov dh, 0
    call Gotoxy
    mov esi, OFFSET mapBuffer
    DrawLoop:
        mov al, [esi]
        cmp al, 0       
        je DoneDrawing
        
        cmp al, 'W'
        je ColorDarkGray
        cmp al, 'L'
        je ColorLava
        cmp al, '.'
        je CheckSkyColor
        cmp al, 'G'
        je ColorGreen
        cmp al, 'B'
        je ColorBrick
        cmp al, 'o'     
        je ColorCoin    
        cmp al, 'C'
        je ColorCloud
        cmp al, 'S'
        je ColorSoil
        cmp al, 'F'
        je ColorFrame
        cmp al, '|'
        je ColorPole
        cmp al, '>'
        je ColorFlag
        cmp al, '+'
        je ColorPowerUp 
        
        ; Default
        mov eax, white + (black * 16)
        call SetTextColor
        jmp PrintChar

    CheckSkyColor:
        cmp currentStage, 2
        jae ColorBlackSky    
        
        ; Level 1: Light Blue Sky
        mov eax, lightBlue + (black * 16)
        call SetTextColor
        mov al, 0DBh     
        jmp PrintChar

    ColorBlackSky:
        mov eax, black + (black * 16)
        call SetTextColor
        mov al, ' '          
        jmp PrintChar

    ColorDarkGray:
        mov eax, gray + (black * 16)  
        call SetTextColor
        mov al, 0DBh
        jmp PrintChar

    ColorLava:
        mov eax, lightRed + (black * 16) 
        call SetTextColor
        mov al, 0DBh
        jmp PrintChar
    ColorGreen:
        mov eax, lightGreen + (black * 16)
        call SetTextColor
        mov al, 0DBh     
        jmp PrintChar
    ColorBrick:
        mov eax, gray + (black * 16) 
        call SetTextColor
        mov al, 0DBh     
        jmp PrintChar
        
    ColorCoin:
        cmp currentStage, 2
        jae CoinBlackBG  
        
        mov eax, yellow + (lightBlue * 16)
        call SetTextColor
        mov al, 'o'
        jmp PrintChar

    CoinBlackBG:
        mov eax, yellow + (black * 16)
        call SetTextColor
        mov al, 'o'
        jmp PrintChar

    ColorPowerUp:
        cmp currentStage, 2
        jae PowerUpBlackBG

        mov eax, lightRed + (lightBlue * 16)
        call SetTextColor
        mov al, '+'
        jmp PrintChar

    PowerUpBlackBG:
        ; Level 2: Red PowerUp on Black
        mov eax, lightRed + (black * 16)
        call SetTextColor
        mov al, '+'
        jmp PrintChar

    ColorCloud:
        mov eax, white + (black * 16)
        call SetTextColor
        mov al, 0DBh     
        jmp PrintChar
    ColorSoil:
        mov eax, brown + (black * 16)
        call SetTextColor
        mov al, 0DBh     
        jmp PrintChar
    ColorFrame:
        mov eax, black + (black * 16)  
        call SetTextColor
        mov al, 0DBh
        jmp PrintChar
    ColorPole:
        mov eax, white + (lightBlue * 16)
        call SetTextColor
        mov al, 0DBh 
        jmp PrintChar
    ColorFlag:
        mov eax, lightRed + (lightBlue * 16)
        call SetTextColor
        mov al, 0DBh 
        jmp PrintChar
    PrintChar:
        call WriteChar
        inc esi
        jmp DrawLoop
    DoneDrawing:
    mov eax, white + (black * 16)
    call SetTextColor
    ret
DrawMap ENDP

DrawPlayer PROC
    mov dl, xPos
    mov dh, yPos
    call Gotoxy

    ; --- COLOR SELECTION LOGIC ---
    
    cmp isPowerUp, 1
    je DrawPowerUpColor

    cmp isGhostMode, 1
    je DrawGhostColor
    
    mov eax, blue + (black * 16)   
    jmp SetColor

DrawPowerUpColor:
    mov eax, lightRed + (black * 16) 
    jmp SetColor

DrawGhostColor:
    mov eax, cyan + (black * 16)   

SetColor:
    call SetTextColor              

    mov al, 0DBh
    call WriteChar  
    mov al, 0DBh
    call WriteChar  
    mov al, 0DBh
    call WriteChar  
    
    ; --- Draw Legs ---
    mov dl, xPos
    inc dh
    call Gotoxy
    mov eax, white + (black * 16)
    call SetTextColor
    mov al, 0DBh
    call WriteChar
    mov eax, black + (black * 16)
    call SetTextColor
    mov al, 0DBh
    call WriteChar
    mov eax, white + (black * 16)
    call SetTextColor
    mov al, 0DBh
    call WriteChar
    mov eax, white + (black * 16)
    call SetTextColor
    ret
DrawPlayer ENDP

UpdatePlayerOldPos PROC
    mov ecx, 2
    mov dh, yPos
    EraseLoopOuter:
        mov dl, xPos
        call Gotoxy
        push ecx
        mov ecx, 3 
        EraseLoopInner:
            cmp currentStage, 2
            jae EraseBlack
            
            mov eax, lightBlue + (black * 16)
            call SetTextColor
            mov al, 0DBh
            jmp DoWrite
            
        EraseBlack:
            mov eax, black + (black * 16)
            call SetTextColor
            mov al, ' ' 
            
        DoWrite:
            call WriteChar
            loop EraseLoopInner
        pop ecx
        inc dh
        loop EraseLoopOuter
        
    mov eax, white + (black * 16)
    call SetTextColor
    ret
UpdatePlayerOldPos ENDP



CheckMarioBossCollision PROC
    cmp bossAlive, 1
    jne NoBossCol

    mov al, xPos
    add al, 3       
    mov bl, bossX
    dec bl          
    cmp al, bl
    jle NoBossCol   

    mov al, bossX
    add al, 4       
    cmp al, xPos   
    jle NoBossCol   

    mov al, yPos
    add al, 2      
    cmp al, bossY   
    jle NoBossCol   

    mov al, bossY
    add al, 3       
    cmp al, yPos    
    jle NoBossCol   

    mov al, yPos
    add al, 2       
    mov bl, bossY
    inc bl         
    cmp al, bl
    jle BossDie     

    dec lives
    cmp lives, 0
    je BossKillsMario

    call UpdatePlayerOldPos
    mov xPos, 5
    mov yPos, 24    
    call DrawPlayer
    ret

BossDie:
    mov bossAlive, 0
    
    mov eax, black + (black * 16)
    call SetTextColor

    mov dl, bossX
    mov dh, bossY
    call Gotoxy
    mov al, ' '
    call WriteChar
    call WriteChar 
    
    mov dl, bossX
    dec dl
    inc dh          
    call Gotoxy
    mov al, ' '
    call WriteChar
    call WriteChar
    call WriteChar

    mov dl, bossX
    inc dh          
    call Gotoxy
    mov al, ' '
    call WriteChar
    call WriteChar
    call WriteChar

    cmp fireActive, 1
    jne SkipFireClear
    mov dl, fireX
    mov dh, fireY
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    mov fireActive, 0   
    SkipFireClear:

    INVOKE PlaySoundA, OFFSET fileBossDie, NULL, SND_ASYNC 
    
    add score, 500       
    
    ret

BossKillsMario:
    mov gameOverFlag, 1   
    ret

NoBossCol:
    ret
CheckMarioBossCollision ENDP

AttemptDestroyBlock PROC
    
    
    cmp isPowerUp, 1
    jne CannotDestroy
    
    mov mapBuffer[eax], '.'
    
    pushad
    mov ebx, ROW_SIZE
    xor edx, edx
    div ebx     
    
    mov dh, al
    mov dl, dl
    call Gotoxy
    
    
    cmp currentStage, 2
    jae DrawBlackVoid
    
    mov eax, lightBlue + (black * 16)
    call SetTextColor
    mov al, 0DBh
    jmp DoDrawSky
    
DrawBlackVoid:
    mov eax, black + (black * 16)
    call SetTextColor
    mov al, ' '
    
DoDrawSky:
    call WriteChar
    popad
    
    
    mov al, 0 
    ret

CannotDestroy:
    mov al, 1 
    ret
AttemptDestroyBlock ENDP


PlayFireworksAnimation PROC
    pushad
    
    mov ecx, 20
    
FireworkLoop:
    push ecx 
    
    mov eax, 90
    call RandomRange
    add eax, 10
    mov esi, eax 
    
    mov eax, 15
    call RandomRange
    add eax, 5
    mov edi, eax 
    
    mov eax, 15
    call RandomRange
    add eax, 1   
    add eax, (black * 16) 
    call SetTextColor
    
    mov eax, esi    
    mov dl, al      
    mov eax, edi   
    mov dh, al      
    call Gotoxy
    mov al, '*'
    call WriteChar
    
    push eax
    INVOKE PlaySoundA, OFFSET fileJump, NULL, SND_ASYNC
    pop eax
    
    mov eax, 50
    call Delay
    
    
    mov eax, esi   
    mov dl, al
    mov eax, edi 
    mov dh, al
    dec dh          
    call Gotoxy
    mov al, '|'
    call WriteChar
    
    mov eax, esi
    mov dl, al
    mov eax, edi
    mov dh, al
    inc dh          
    call Gotoxy
    mov al, '|'
    call WriteChar
    
    mov eax, esi
    mov dl, al
    dec dl         
    mov eax, edi
    mov dh, al
    call Gotoxy
    mov al, '-'
    call WriteChar
    
    mov eax, esi
    mov dl, al
    inc dl          
    mov eax, edi
    mov dh, al
    call Gotoxy
    mov al, '-'
    call WriteChar
    
    mov eax, esi
    mov dl, al
    dec dl
    mov eax, edi
    mov dh, al
    dec dh
    call Gotoxy
    mov al, '\'
    call WriteChar
    
    mov eax, esi
    mov dl, al
    inc dl
    mov eax, edi
    mov dh, al
    dec dh
    call Gotoxy
    mov al, '/'
    call WriteChar
    
    mov eax, esi
    mov dl, al
    dec dl
    mov eax, edi
    mov dh, al
    inc dh
    call Gotoxy
    mov al, '/'
    call WriteChar
    
    mov eax, esi
    mov dl, al
    inc dl
    mov eax, edi
    mov dh, al
    inc dh
    call Gotoxy
    mov al, '\'
    call WriteChar
    
    mov eax, 100
    call Delay
    
    mov eax, black + (black * 16)
    call SetTextColor
    
    mov eax, edi
    mov dh, al
    dec dh     
    
    push ecx
    mov ecx, 3  ; 3 Rows
ClearRows:
    push ecx
    
    mov eax, esi
    mov dl, al
    dec dl      
    
    mov ecx, 3  
    ClearCols:
        call Gotoxy
        mov al, ' '
        call WriteChar
        inc dl
        loop ClearCols
        
    pop ecx
    inc dh
    loop ClearRows
    pop ecx 
    
    pop ecx 
    dec ecx
    jnz FireworkLoop
    
    popad
    ret
PlayFireworksAnimation ENDP

END main