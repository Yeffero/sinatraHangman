
def init

  session["name_player"]=$name_player
  $try=0
  $secret_word=""
  $answer=""
  $incorrect=[]
  $secret_word=random_word
  init_answer
  session['try']=$try
  session["secret_world"]=$secret_word
  session["answer"]=$answer
  session["incorrect"]=$incorrect
  session["before"]="1"

end
def reinit
  session["before"]=session["before"].to_i+1
  $name_player=session["name_player"]
  $try=session['try']
  $secret_word=session["secret_world"]
  $answer=session["answer"]
  $incorrect=session["incorrect"]


end

def random_word
  word=""
  if File.exists?("5desk.txt")
    File.open("5desk.txt")
    array_of_lines = File.readlines("5desk.txt")
    #puts "Total de lineas del archivo es #{array_of_lines.length}"
    loop do
        word =array_of_lines.sample
        word.gsub!(/\n/,'')
        #puts "la palabra elegida en el loop es #{word}"
        if word.length >5 && word.length <=12
          break
        end
    end

  else
    #puts "ERROR! there is not 5desk.txt file, PLease check it"
    word=""

  end
  #puts "la palabra elegida es #{word} y tinee #{word.length} caracteres "
  idx=-1
  word.each_char {|c| $answer[idx+=1]="_"}
  word
end

def init_answer

  temporal=$secret_word.scan(/\w/)
  #puts "Valor de temporal #{temporal}"
  #puts "Current Answer Status :   #{$answer}"
  temporal.each_with_index { |chr,idx |

        if ($answer[idx]=="_" )
          $answer[idx]="_"
        end
     }
#puts "Current Guess Status :   #{$answer}"

end





def add_game

  temporal=$incorrect.join("")
  session["name_player"]=$name_player
  session["try"]=$try-1
  session["secret_world"]=$secret_word
  session["answer"]=$answer
  session["incorrect"]=temporal
  end



def delete_table
    #session["name_player"]==""
    session['try']=0
    session['secret_word']=""
    session['answer']=""
    session['incorrect']=""
end


def play_game

  puts "Lets play,you have #{10-$try} oportunities"


  while $try<10 do
    $try+=1
    puts "Lets play, this is your #{$try} oportunity"
    if check_control
      puts "You Win!!!!"
      $try=11
      delete_table
    end

  end
if $g!="S"
  puts "Sorry You lost . Secret Word is #{$secret_word}"
  delete_table
end

end

def check_control
  $g.downcase!
  $secret_word.downcase!
  ok=0
  temporal=[]

      temporal=$secret_word.scan(/\w/)
      #puts "Valor de temporal #{temporal}"
      #puts "Current Answer Status :   #{$answer}"
      temporal.each_with_index { |chr,idx |
        if chr==$g
            $answer[idx]=chr
            ok=1
        else
            if ($answer[idx]=="_" )
              $answer[idx]="_"

            end
        end   }
        #puts "valor de ok #{ok}"
        if ok== 0
          $incorrect << $g
        end
  #puts "Current Guess Status :   #{$answer}"
  #puts "Current incorrect letters used :  #{$incorrect}"
  string_answer=$answer
   #puts "Current Guess Status string:   #{string_answer}"
  if string_answer == $secret_word
    return true
  else
    return false
  end
end



#puts "la palabra secreta escogida es #{$secret_word}"




#play_game
