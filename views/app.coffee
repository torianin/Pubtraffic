class Main
   test:->
    pusher = new Pusher("3da8282fe36a89d40595")
    channel = pusher.subscribe("my-channel")
    channel.bind "my-event", (data) ->
      $('#last').html("<hr>" + data.message + $('#last').html() )
      $('#notification').html(data.message)
      document.title = data.message;
new Main().test()
