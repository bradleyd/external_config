defmodule Example.Foo do
 
  ## this is a silly example but want to show how you could use it
  def start do
     config = Example.Config.lookup(:tcp_host) 
     {:ok, socket} = :gen_tcp.connect(to_char_list(config.host), config.port, [:binary, {:packet, 0}])
     socket
  end
end

