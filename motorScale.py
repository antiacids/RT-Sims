# motorScale.py - Scales the impulse of a motor file
# Created by Jakob Coray (jcoray at mit dot edu) on 10/30/18

import csv
motorFile = "Rockets_and_motors/CL curve sim.eng"
initialImpulse = 6.963;
finalImpulse = 7.6;
with open(motorFile, 'r') as rf:
    with open('Rockets_and_motors/76kns.eng', 'w') as wf:
        reader = csv.reader(rf, delimiter=' ')
        writer = csv.writer(wf, delimiter=' ')
        for row in reader:
            if row[0] != '':
                writer.writerow(row)
                continue
            row[4] = str(float(row[4])*finalImpulse/initialImpulse)
            writer.writerow(row)
        
