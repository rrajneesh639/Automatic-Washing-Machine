# Automatic Washing Machine - Verilog Implementation

This project is a Verilog-based implementation of an automatic washing machine, designed to simulate the various stages of a washing cycle. The design includes multiple stages that the machine goes through, from checking the door status to spinning the clothes dry. The simulation for this project was conducted using GTKwave.

## Overview

The automatic washing machine design is composed of six distinct stages:

1. **Check Door**: Ensures the door is securely closed before the washing process begins.
2. **Fill Water**: Fills the washing drum with the required amount of water.
3. **Add Detergent**: Adds detergent to the water for the washing process.
4. **Cycle**: The washing machine agitates the clothes to clean them.
5. **Drain Water**: Drains the dirty water from the drum after the washing cycle.
6. **Spin**: Spins the clothes to remove excess water before the cycle ends.

### Input Ports

- **clock**: System clock signal.
- **reset**: Resets the machine to its initial state.
- **door_close**: Indicates whether the washing machine door is closed.
- **start**: Initiates the washing process.
- **filled**: Indicates that the drum is filled with water.
- **detergent_added**: Confirms that detergent has been added.
- **cycle_timeout**: Signals the completion of the washing cycle.
- **drained**: Indicates that the water has been drained.
- **spin_timeout**: Signals the completion of the spinning process.

### Output Ports

- **door_lock**: Locks the door during the washing process.
- **motor_on**: Activates the motor for washing or spinning.
- **fill_valve_on**: Controls the valve to fill water into the drum.
- **drain_valve_on**: Controls the valve to drain water from the drum.
- **done**: Indicates that the entire washing process is complete.
- **soap_wash**: Signals the soap washing phase.
- **water_wash**: Signals the water washing phase.

## Simulation Tool

The design was simulated using **GTKwave**, a powerful waveform viewer that allows for easy verification and debugging of the Verilog code.

## Future Enhancements

- **Advanced Cycle Modes**: Incorporating multiple washing modes, such as delicate, heavy, and quick wash.
- **Temperature Control**: Adding functionality to regulate water temperature based on fabric type.
- **User Interface Integration**: Developing a simple user interface to interact with the washing machine, allowing users to select different modes and settings.
- **Energy Efficiency Optimization**: Improving the design to optimize energy and water usage during the washing process.
- **Error Handling**: Enhancing the system to handle errors like power failure or water shortage and recover gracefully.
