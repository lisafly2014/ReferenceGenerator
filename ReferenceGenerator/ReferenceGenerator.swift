//
//  ReferenceGenerator.swift
//  E-TS Mobile
//
//  Created by WH Software on 5/12/19.
//  Copyright © 2019 WH Software. All rights reserved.
//

import Foundation

struct ReferenceGenerator{
    enum DateComponents:Int,CaseIterable{
        case second,minute,hoursOfDay,dayOfMonth,monthOfYear,year
        
        func calendarComponent() -> Calendar.Component{
            switch self{
            case .second: return .second
            case .minute: return .minute
            case .hoursOfDay: return .hour
            case .dayOfMonth: return .day
            case .monthOfYear: return .month
            case .year: return .year
            }
        }
    }
    
   private func getComponentValue(with date: Date, only component: Calendar.Component) -> Int{
        let val = Calendar.current.component(component, from: date)
    //        print("\(component): \(val)")
        return  val
    }
    
    func generateReference() ->String{
        var specialDate:Int = 0
        var bitOffset: Int = 0
        let componentsValueArray: [Int] = [60,60,24,31,12,100] //second,minute,hour_of,day_of_month,month,year
        
        let date = Date()
        for component in DateComponents.allCases{
            if component == .second{
                specialDate += getComponentValue(with: date, only: component.calendarComponent())
            }else if component == .year{
                specialDate += ((getComponentValue(with: date, only: component.calendarComponent()) - 2000) % 100) << bitOffset
            }else{
                specialDate += getComponentValue(with: date, only: component.calendarComponent()) << bitOffset
            }
            
            bitOffset += binaryLength(number: componentsValueArray[component.rawValue])
        }
        
        let dataLength =  Int(8 * ceil(Double(bitOffset) / 8 ) / 8)
        //        print("dataLength: \(dataLength)")
        
        /// below data1 and data2 just for debug purpose
        
        
        
        let data1 = NSData(data: specialDate.data)
        print(getHexString(fromData: data1))
        
        let data2 = intToByteArray(number: specialDate)
        print(fromByteArrayToHexString(bytes: data2))
        
        let specialDateData = [UInt8](specialDate.data)
        var trimmedSpecialDate:[UInt8] = Array()
        
        for i in 0 ..< dataLength {
            trimmedSpecialDate.append(specialDateData[i])
        }
        
        //        print(trimmedSpecialDate)
        
        let base32String = base32Encode(Data(trimmedSpecialDate))
         print(base32String)
        
        return base32String
        
        
    }
    
    func intToByteArray(number: Int) -> [UInt8]{
        var result:[UInt8] = Array()
        var _number = number
        let byteMask = 0xFF
        
        for _ in 0 ..< MemoryLayout<UInt64>.size {
            result.insert(UInt8(_number & byteMask), at: 0)
            _number >>= 8
        }
        
        return result
    }
    
    private  func getHexString(fromData data: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: data.length)
        data.getBytes(&bytes, length: data.length)
        
        return fromByteArrayToHexString(bytes: bytes)
        //        var hexString = ""
        //        for byte in bytes {
        //            hexString += String(format:"%02x", UInt8(byte))
        //        }
        //        return hexString
    }
    
    private func fromByteArrayToHexString(bytes: [UInt8]) -> String{
         var hexString = ""
         for byte in bytes {
             hexString += String(format:"%02x", UInt8(byte))
         }
         return hexString
     }
    
    private func binaryLength(number:Int) ->Int{
        return String(number,radix:2).count
    }
}

extension Int{
    var data: Data{
        var int = self
        return Data(bytes: &int,count: MemoryLayout<Int>.size)
    }
}
