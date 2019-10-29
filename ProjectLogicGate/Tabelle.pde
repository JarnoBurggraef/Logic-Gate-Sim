void SaveTabelle() {
  selectOutput("Select a location to save", "SaveTab");
}

void SaveTab(File selection) {
  if (selection!=null) {
    String path = selection.getAbsolutePath();

    ArrayList<Component> inputs = getInputs();
    int ins = inputs.size();
    ArrayList<Component> outputs = getOutputs();
    int outs = outputs.size();

    String[] data = new String[(int)pow(2, ins)+1];
    data[0] = "n | ";
    for (int i=0; i<ins; i++) {
      data[0] += str(i) + " | ";
    }
    data[0] += " ";
    for (int i = 0; i<outs; i++) {
      data[0] += str(i);
      if (i!=outs-1) {
        data[0] += " | ";
      }
    }
    int[][] bins = createBins(ins);

    for (int i = 0; i<pow(2, ins); i++) {
      int j = i+1;
      data[j] = str(i) + " | ";
      for (int k = 0; k<ins; k++) {
        data[j] += str(bins[i][k])+" | ";
      }  
      for (int k = 0; k<ins; k++) {
        inputs.get(k).inputs[0] = bins[i][k]==1 ? true : false;
      }
      workAllComponents();
      data[j] += " ";
      for (int k = 0; k<outs; k++) {
        data[j] += str(outputs.get(k).outputs[0] ? 1 : 0 );
        if (k !=outs-1) {
          data[j] += " | ";
        }
      }
    }
    saveStrings(path, data);
  }
}

int[][] createBins(int len) {
  int p = int(pow(2, len));
  int[][] out = new int[p][len];
  for (int i=0; i<len; i++) {
    int l = int(pow(2, i));
    for (int j=l; j<p; j+=2*l) {
      for (int k=j; k<j+l; k++) {
        out[k][len-1-i] = 1;
      }
    }
  }
  return out;
}
