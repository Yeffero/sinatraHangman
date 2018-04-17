require "sinatra"
#require_relative "db/models"
require_relative "hangman"

configure do
  enable :sessions
  set :session_secret, "secret"
end
set :colorbk,  'white'

$try=0
$name_player=""
$secret_word=""
$answer=""
$incorrect=[]


get "/" do

  message=" "


    @session = session
    #message=@session["name"]

    settings.colorbk= 'green'
 if @session["name_player"]
   message="Ya habia entrado a jugar"
 else
    message="No ha entrado"
 end
  erb :index0, :locals => {:message => message,:colorbk => settings.colorbk}
end

post "/name" do
  if $name_player == ""
    $name_player=params[:name]
  end
  init
    puts "Post #{$secret_word}"
  redirect "/play_game" , 307

end


post "/play_game" do
  message1=""
  message2=""
    if params[:guess].to_s.length==1  && $try <10 #session['try']
        $try+=1
        $g=params[:guess]

        if check_control
          #message ="You Win!!!!"

          delete_table
          redirect "/endgame"
        end
        message1+=" Current Guess Status :   #{$answer.to_s.upcase}"
        message2+=" Current incorrect letters used :  #{$incorrect.to_s.upcase}"
        #$name_player=params[:name]
        #session["name_player"]=$name_player
        session['try']=$try
        session["secret_world"]=$secret_word
        session["answer"]=$answer
        session["incorrect"]=$incorrect
        if $try == 10
        #puts "Valor de #{$try} "
        redirect "/endgame"
        end

    elsif params[:guess].to_s.length != 1
        message1 ='Please only one character for every guess'
        message2=""
    end


  #Esto funciono muy bien --if Game.find_by(sid: @session["session_id"].to_s)
  #  "Hello again"
  #else
  #  Game.create(
  #      sid: @session["session_id"].to_s,
  #      name_player: params[:name],
  #      secret_world: "",
  #      answer: "",
  #      incorrect: ""
  #    )
  #  end

  erb :play, :locals => {:session => session,:message1 =>message1,:message2=>message2}
end


get "/endgame" do

  if $secret_word != ""
    if $answer == $secret_word
      message1= "You Win Congratulations !!"
    else
      message1="You Lost !!!"
    end

    message3="The secret word was :  #{$secret_word.to_s.upcase}"

    name=$name_player
    try=$try

    $try=0
    #$name_player=""
    $secret_word=""
    $answer=""
    $incorrect=[]
  end

    erb :endgames, :locals => {:name => name,:message1 => message1,:message3 =>message3,:try => try}
end
