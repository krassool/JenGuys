int dir1=1;
int dir2=-1;
int dir3=1;
int dir4=1;
int dir5=1;

float offset1 = 0;
float offset2 = 0;
float offset3 = 11;
float offset4 = 33;
float offset5 = 0;


void adjustAngles(){
    qa1 = (q1*dir1)-offset1;
    qa2 = (q2*dir2)-offset2;
    qa3 = ((q3*dir3)-offset3)+q2;
    qa4 = (q4*dir4)-offset4;
    qa5 = (q5*dir5)-offset5;
}
