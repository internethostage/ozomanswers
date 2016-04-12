class WelcomeController < ApplicationController

  #This defined an 'action' called index for the 'WelcomeController'
  def index
    # render text: "Hello World!"

    # By default (if nothing is typed here), Rails will render: views/welcome/index.html.erb (when receiving a request that has an HTML format)
    #You can also do: render :index or render "/home_other_folder/some_other_action"


    #if you use another format by going to url such as 'home.text'
    #Rails will render a templte according to that format so in the case of '/home.text' it will be: views/welcome/index.text.erb
  end

  def about
  end

end
