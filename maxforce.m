function [Ft,dx,mf]=maxforce(xfall,m)
    %material properties
        el_factor=1.004;
        Length=xfall;
        tensile_strength=2500; %lbs
        Area=.2*.093/144; %ft^2
        Ym=el_factor*Length/tensile_strength;
        k=Ym*Area/Length;
    g=32.15; %ft/s^2
    v0=sqrt(2*xfall*g);
    dt=100;
    
    v=[];
    dx=[];
    Ft=[];
    a=[];
    v(1)=v0;
    dx(1)=0;
    Ft(1)=0;
    a(1)=9.8;
    i=1;
    while i<1800
        i=i+1;
        Ft(i-1)=-k*dx(i-1);
        Ft(i)=0;
        a(i)=0;
        a(i-1)=g+Ft(i-1)/m;
        dx(i)=v(i-1)*dt+a(i-1)*dt^2+dx(i-1);
        v(i)=a(i-1)*dt+v(i-1);
    end
    mf=max(abs(Ft));
end