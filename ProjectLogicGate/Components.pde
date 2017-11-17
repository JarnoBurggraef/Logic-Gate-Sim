class AndGate extends Component {
  AndGate(){
    super();
    inputSize = 2;
    outputSize = 1;
    setupIO();
  }
  void Work(){
    outputs[0] = inputs[0] && inputs[1];
  }
}

class OrGate extends Component {
  OrGate(){
    super();
    inputSize = 2;
    outputSize = 1;
    setupIO();
  }
  void Work(){
    outputs[0] = inputs[0] || inputs[1];
  }
}

class NotGate extends Component {
  NotGate(){
    super();
    inputSize = 1;
    outputSize = 1;
    setupIO();
  }
  void Work(){
    outputs[0] = !inputs[0];
  }
}