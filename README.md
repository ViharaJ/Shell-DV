## How to create your own shell script to automate DV-GUI


### Setup
1. In a terminal run `dv-runtime`
2. In another terminal, activate the GUI with `dv-gui`. Within the GUI, select the XML file you'll be running. 
- (Alternatively) You could also open the DV GUI, go to *Connect to -> Manage runtime instances*. By clicking that it should connect to our runtime.
3. Finally, open another terminal and run `dv-control`


### Figuring out what calls you'll need
Now, everything should be connected and working due to the default settings. From now on, we'll just be working the last terminal. All the available calls  for dv-control can be found [here](https://dv-runtime.inivation.com/master/runtime/usage/dv-control.html#command-line-interface).


Your just need to call `dump_tree`. This will show you all the modules used in the "mainloop"(your process/project) and also available modules. 

Beware it's a large dump, but you'll see something like this. 
```
NODE: /mainloop/event_visualizer/
ATTR: /mainloop/event_visualizer/ | backgroundColor, string | FFFFFF
``` 

`node` represents the module, while `attr`represents the parameters and the final value you see is the current value of the parameter. 

So, to update a parameter you can run something like this
``` 
set /mainloop/event_visualizer/ backgroundColor "1E2534"
``` 

And similarly to get the value of a module parameter
``` 
get /mainloop/event_visualizer/ backgroundColor
``` 

And, that's really it. FIgure out what calls you need and then incorporate them into your script!

<u>Note:</u> The official documentation says when referencing the nodes you're meant to write in the form `/mainloop/accumulator` but I found that this didn't work so I've putting in the paths with a forward slash at the end, `/mainloop/accumulator/`.


### Writing and usage of shell-script

They way my script works is that I do steps 1 and 2 from Setup and then run my shell script. It should be possible to probably compact everything into one script but that is a TODO.
