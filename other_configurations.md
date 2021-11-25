# Touchpad config
1. If using synclient
```
sudo nano /etc/X11/Xsession.d/100synaptics
```
2. Write inside (the value doesn't matter, the important thing is that is negative)

```
synclient VertScrollDelta=-75
synclient HorizScrollDelta=-75
```
