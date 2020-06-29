//
//  SecondViewController.swift
//  Camille's App Idea
//
//  Created by Justin Pong on 10/21/19.
//  Copyright © 2019 Justin Pong. All rights reserved.
//
import Charts
import UIKit

extension LineChartView {

    private class LineChartFormatter: NSObject, IAxisValueFormatter {
        
        var labels: [String] = []
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return labels[Int(value)]
        }
        
        init(labels: [String]) {
            super.init()
            self.labels = labels
        }
    }
    
    func setLineChartData(xValues: [String], yValues: [Double], label: String, target: Double) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<yValues.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: label)
        let chartData = LineChartData(dataSet: chartDataSet)
        
        let chartFormatter = LineChartFormatter(labels: xValues)
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
        
        self.data = chartData
        self.setScaleEnabled(false)
        let xAxis2 = self.xAxis
        xAxis2.centerAxisLabelsEnabled = false
        xAxis2.setLabelCount(5, force: true)
        
        self.leftAxis.axisMaximum = target + 0.1
        self.leftAxis.axisMinimum = (yValues.min() ?? 0) - 0.1
        
        let targetLine = ChartLimitLine(limit: target, label: "")
        self.leftAxis.addLimitLine(targetLine)
    }
}

class DataTrackerViewController: UIViewController {

    @IBOutlet weak var HeightBtn: UIButton!
    @IBOutlet weak var WeightBtn: UIButton!
    @IBOutlet weak var BMIBtn: UIButton!
    @IBOutlet weak var LineChart: LineChartView!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var UpdateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dates = ["11/11/19", "11/12/19", "11/13/19", "11/14/19", "11/15/19"]
        let height = [5.3, 5.3, 5.31, 5.31, 5.31] // in feet
        let weight = [135.7, 135.9, 135.4, 135.6, 135.5] // in pounds
        var bmi: [Double] = []
//        for i in 0..<height.count {
//            let calcBMI = 703 * weight[i] / pow(Double(height[i] * 12), Double(2))
//            bmi.append(calcBMI)
//        }
        let weightTarget = 135
        let bmiTarget = 22
        
        setChart(dataPoints: dates, values: height)
        // Do any additional setup after loading the view.
    }
        
    func setChart(dataPoints: [String], values: [Double]) {
        
//        var dataEntries: [ChartDataEntry] = []
//
//        for i in 0..<dataPoints.count {
//            print(i)
//            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
//            dataEntries.append(dataEntry)
//        }
        LineChart.setLineChartData(xValues: dataPoints, yValues: values, label: "Height", target: 5.3)
//        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Height")
//        let lineChartData = LineChartData(dataSet: lineChartDataSet)
//        LineChart.data = lineChartData
        LineChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
    }
}

