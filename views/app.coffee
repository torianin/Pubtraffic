class Main
   test:->
    pusher = new Pusher("3da8282fe36a89d40595")
    channel = pusher.subscribe("my-channel")
    channel.bind "my-event", (data) ->
      $('#notification')
      alert "Teraz " + data.message

new Main().test()
