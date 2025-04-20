# Home Assistant additions
This sub-folder includes all the necessary information on how to create all facilities in an Home Assistant instance to use this project *as it is*.

This is intended more as a guideline on what you need to add to an Home Assistant instance to make things work rather than a step-by-step, copy and paste tutorial.

## Scripts
In order to interpret commands related to color lights, there is a script that needs to be added.
The script ["ESPHome HueSaturation light set"](scripts.yaml) can be copied verbatim.

## Helper entities
Automated lights automation override requires several entities for each controlled lights as well as an automation.

Each light requires the following helper entities:

- input_boolean to toggle on/off the override feature. 
  - This is normally what your would use in the "Bypass" section (option 3: Bypass Switch - Keep The Lights Current State) of your ['Sensor Light'](https://community.home-assistant.io/t/481048) or ['Smart Light'](https://community.home-assistant.io/t/527354) blueprint automation.
- 4 * input_buttons to add/substract time on how long automation override should stay on.
- input_datetime to hold the amount of time the automation override should be set to on override activation.
- timer to make this whole thing work.
- A template sensor to properly display the time at which the override will be deactivated.
  - An example of the model to set is located in the file [template_sensor_state_model.yaml](template_sensor_state_model.yaml)


List of radio stations from Music Assistant must be held up in an input_select helper entity. On creation, Home Assistant requires at least 1 entry be present on entity creation. Just populate with whatever. An automation will be responsible to populate it with the right data. 


## Automations

### Main Automation

This project requires some help from Home Assistant.
Currently, the [main automation](hmi_interface_automation.yaml) is in charge of handling the following:
- Media/music related actions coming from the HMI (Assumes using Music Assistant)
  - Mute
  - Play/Pause
  - Next/Previous tracks
  - Repeat mode
  - Shuffle On/Off
  - Playlists/Radio activation
- Regenerate the list of Radio station from Music Assistant.
  - Music Assistant does not allow radio stations in playlists
  - Requires instanciation of input_select helper to hold radio stations names
- Increase/Reduce LCD brightness depending of presence in the room
- Run [LCD antiburn](https://esphome.io/cookbook/lvgl.html#prevent-burn-in-of-lcd) pattern daily, early in the morning.


### Automated lights override
A single automation per light is required to bind all the entites above together and make the automated light override feature work.

Create a blank automation, copy the content of the [override_automation.yaml](override_automation.yaml) file while replacing the entities with the helper entities you created.