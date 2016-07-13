defmodule Example.Foo do
 
  ## this is a silly example but want to show how you could use it
  def start do
     config = Example.Config.lookup(:amqp) 
     :gen_tcp.connect(config.host, config.port, [])
  end
end

