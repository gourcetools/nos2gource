
# <b>nos2gource</b>                  <br>
<img src="https://img.shields.io/badge/License-MIT-orange.svg"> <br> <br>
 <img src="https://nostr.build/i/2226.png" alt="Combined" width="500px"> <br> <br>


# <b>🍩 What is nos2gource?</b><br>
<br>
<b>nos2gource is a low level coding bash script made to display nostr events inside Gource.</b><br>
It's main purpose it to download events from <b>multiple</b> relays, create logs, combine them into one big file that we can open with Gource.<br>
It's just...funny..<br>
<br>

# <b>⚙️ Requirements:</b><br>
- `nostcat` , `gource` <br>
- Optional: `FFmpeg` for recording with gource<br>
<br>

# Links 

<br>
 `nostcat` : https://github.com/blakejakopovic/nostcat <br>
 `gource` : https://github.com/acaudwell/Gource/    <br>

 <br>
 
# <b>✔️ How to use nos2gource?</b><br>
1) 📜  Open <b>relays.txt</b> and replace links with desired URLs - one link per line.<br>
2) 🧰  Launch ./dl* script, you can edit the variable to change how many events you ask each relays.
3) ⌛  Wait
4) 😃  You should see a gource now.<br>
<br>


🙋‍♂️ Need help? Telegram: <b>@bitpaint</b> | Twitter: <b>@bitpaintclub<br></b>

`cargo install nostcat`
`git clone https://github.com/gourcetools/nos2gource`
`cd ./nos2gource`
`./src/dl*`
