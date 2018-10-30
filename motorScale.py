import csv
motorFile = "Rockets_and_motors/CL curve sim.eng"
with open(motorFile, 'r') as rf:
    with open('newmotor.eng', 'w') as wf:
        reader = csv.reader(rf, delimiter=' ')
        writer = csv.writer(wf, delimiter=' ')
        for row in reader:
            if row[0] != '':
                writer.writerow(row)
                continue
            row[4] = str(float(row[4])*8/6.9)
            writer.writerow(row)
        
