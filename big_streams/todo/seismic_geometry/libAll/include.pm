package include;
use Exporter ();

@ISA = qw(Exporter);
@EXPORT_OK = qw($HOME $DATA_FAULTS $DATA_LIDAR $DATA_RELIEF $DATA_TOPO $PS $land
scape $limits $no_head $no_tail $portrait $projection $smoothcontour $ticks $ver
bose);
  
# ENVIRONMENT VARIABLES FOR THIS PROJECT
   $HOME            =          '/data2/gom/Marrero/';
   $DATA_FAULTS     =           $HOME.'data/faults';
   $DATA_LIDAR      =           $HOME.'data/LIDAR';
   $DATA_RELIEF     =           $HOME.'data/relief';
   $DATA_SEISMICS   =           $HOME.'data/seismics';
   $DATA_TOPO       =           $HOME.'data/topo';
   $PS              =           $HOME.'ps';

# GMT VARIABLES
   $landscape    = ' -L'  ;
   $portrait     = ' -P'  ;
   $no_tail      = ' -K'  ;
   $no_head      = ' -O ' ;
   $verbose      = ' -V'  ;
   $projection   = ' -Jx.003';
#   $limits = '680405./692670./3334125./3348180. ' ;
#       $limits = '91.1250/-91.0000/+30.1250/+30.2500   ';
   $limits= '777695.000000/790130.000000/3294550.000000/3308715.000000';
   $smoothcontour = ' -S4' ;
   $ticks         = ' -Bf1000a5000' ;

