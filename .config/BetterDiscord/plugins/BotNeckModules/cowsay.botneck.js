// You must have cowsay installed and in the path.
// Search for '//!' and follow those instructions!

const { spawn } = require("child_process")

class cowsay {
  constructor() {
    this.permissions = ["authorized_request"]
    this.command = "cowsay"
    this.description = "sends cowsay messages"
    this.usage = "cowsay [args, just as when entered into the terminal]"
  }

  execute(message, args) {
    delete message["content"]
    //args = JSON.parse(args)
    console.log(args[0])

    if (BotNeckAPI.getArgumentNumber(args) < 1)
      return (message["embed"] = BotNeckAPI.generateError(
        "You need at least 1 arguments for this command!"
      ))

    let arguments_ = ""
    for (var i = 0; i < BotNeckAPI.getArgumentNumber(args); i++) {
      console.log(args[i])
      if (i != BotNeckAPI.getArgumentNumber(args) - 1) {
        arguments_ += args[i] + " "
      } else {
        arguments_ += args[i]
      }
    }
    message["content"] = arguments_

    //! be sure to remove the env: part if your cows are in the default path or change it to your home dir
    const cow = spawn("cowsay", [arguments_], {
      shell: true,
      env: { COWPATH: "/home/legend/cows" },
    })

    cow.stdout.on("data", (data) => {
      BotNeckAPI.nextMessagePost(() => {
        console.log("message sent!")
        let id
        id = BotNeckAPI.getLastUserMessageId()
        let cow_cow = new TextDecoder("utf-8").decode(data)
        $.ajax({
          type: "PATCH",
          url:
            "https://discordapp.com/api/v6/channels/" +
            BotNeckAPI.getCurrentChannelId() +
            "/messages/" +
            id,
          dataType: "json",
          contentType: "application/json",
          data: JSON.stringify({
            content: "```" + cow_cow + "```",
          }),
          beforeSend: function (xhr) {
            BotNeckAPI.setAuthHeader(xhr, APIKey)
          },
          success: function (data2) {
            console.log(data2)
          },
        })
      })
    })

    cow.stderr.on("data", (data) => {
      console.error(`stderr: ${data}`)
      //return message["embed"] = BotNeckAPI.generateError("cowsay printed an error")

      BotNeckAPI.generateError("cowsay printed an error")
    })
  }
}
