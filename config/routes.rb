# encoding: utf-8

Adhearsion.router do

  # Specify your call routes, directing calls with particular attributes to a controller

  route 'default' do
    answer
    say "Hello World!"
  end
end
