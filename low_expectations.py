from textgenrnn import textgenrnn
low_expectations = textgenrnn('low expectations full 1 epoch.hdf5')
def generate_text(string = "", temp = 0.5):
    s = low_expectations.generate(1,
                                    temperature = temp,
                                    return_as_list = True,
                                    progress = False,
                                    prefix = string)[0]
    return(s)

print(generate_text())
