//+------------------------------------------------------------------+
//|                                       CustomIndicatorChecker.mq4 |
//|                                 Copyright 2017, Keisuke Iwabuchi |
//|                                         http://order-button.com/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Keisuke Iwabuchi"
#property link      "http://order-button.com/"
#property version   "1.00"
#property strict
#property indicator_chart_window


#define OBJ_NAME "CsutomIndicatorCheckerVLine"


sinput string IndicatorName = "";


int OnInit()
{
   showComment(0);
   addVLine(Time[0]);
   return(INIT_SUCCEEDED);
}


int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   return(rates_total);
}


void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
   if(id == CHARTEVENT_CLICK) {
      int sub_window;
      datetime time;
      double price;
      ChartXYToTimePrice(0, (int)lparam, (int)dparam, sub_window, time, price);
      
      for(int i = 0; i < Bars; i++) {
         if(Time[i] == time) {
            showComment(i);
            setTimeToVLine(Time[i]);
            break;
         }
      }
   }
}


void OnDeinit(const int reason)
{
   Comment("");
}


void showComment(const int shift)
{
   Comment("Indicator name:", IndicatorName, "\n",
           "Time:", Time[shift], "\n",
           "計算項目0:", iCustom(_Symbol, 0, IndicatorName, 0, shift), "\n",
           "計算項目1:", iCustom(_Symbol, 0, IndicatorName, 1, shift), "\n",
           "計算項目2:", iCustom(_Symbol, 0, IndicatorName, 2, shift), "\n",
           "計算項目3:", iCustom(_Symbol, 0, IndicatorName, 3, shift), "\n",
           "計算項目4:", iCustom(_Symbol, 0, IndicatorName, 4, shift), "\n",
           "計算項目5:", iCustom(_Symbol, 0, IndicatorName, 5, shift), "\n",
           "計算項目6:", iCustom(_Symbol, 0, IndicatorName, 6, shift), "\n",
           "計算項目7:", iCustom(_Symbol, 0, IndicatorName, 7, shift));
}

void addVLine(const datetime time)
{
   ObjectCreate(0, OBJ_NAME, OBJ_VLINE, 0, time, Close[0]);
}

void setTimeToVLine(const datetime time)
{
   ObjectSet(OBJ_NAME, OBJPROP_TIME1, time);
}
