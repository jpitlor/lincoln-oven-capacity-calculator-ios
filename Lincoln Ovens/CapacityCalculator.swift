/// Coded by Jordan Pitlor, 2015
/// Formulas by Rob Townsend, 2002 (Updated by Christina Glaser, 2008)
/// <p/>
/// Please note that the figures above are potential capacity only and individual results will vary.
/// Actual capacity will fluctuate due to differences in environment, the type of product, ingredients,
/// finger kit, type of oven and oven temperature.

import Foundation
import Darwin

public class CapacityCalculator {
	let PI = M_PI

	/// Belt Width
	/// <p/>
	/// in
	private final let BW: Double


	/// Oven Capacity
	/// <p/>
	/// in
	private final let OC: Double


	/// Bake Time
	/// <p/>
	/// min
	private final let BT: Double


	/// Pan Diameter
	/// <p/>
	/// in
	private final let PD: Double


	/// Pan Width
	/// <p/>
	/// in
	private final let PW: Double


	/// Pan Length
	/// <p/>
	/// in
	private final let PL: Double


	/// Used by the app to tell the calculator if the pan is round
	/// <p/>
	/// boolean
	private final let panIsRound: Bool


	/// Constructor
	///
	/// :param: beltWidth    input - {@see BW}
	/// :param: ovenCapacity input - {@see OC}
	/// :param: bakeTime     input - {@see BT}
	/// :param: panDiameter  input - {@see PD}
	public init(beltWidth: Double, ovenCapacity: Double, bakeTime: Double,
		 panDiameter: Double) {
		self.BW = beltWidth
		self.OC = ovenCapacity
		self.BT = bakeTime
		self.PD = panDiameter
		self.panIsRound = true

		self.PL = 0
		self.PW = 0
	}


	/// Constructor
	///
	/// :param: beltWidth    input - {@see BW}
	/// :param: ovenCapacity input - {@see OC}
	/// :param: bakeTime     input - {@see BT}
	/// :param: panWidth     input - {@see PW}
	/// :param: panLength    input - {@see PL}
	public init(beltWidth: Double, ovenCapacity: Double, bakeTime: Double, panWidth: Double, panLength: Double) {
		self.BW = beltWidth
		self.OC = ovenCapacity
		self.BT = bakeTime
		self.PL = panLength
		self.PW = panWidth
		self.panIsRound = false

		self.PD = 0
	}

	/// Calculates the capacity of the oven
	///
	/// :returns: pans/hr
	public func calculateCapacity() -> Double {
		var result: Double
		if (panIsRound) {
			result = self.IRC()
		} else {
			result = self.ISC()
		}

		return round(result * 10) as Double / 10
	}


	/// Velocity for Round Pans
	///
	/// :returns: in/hr
	private func CVEL() -> Double {
		return OC / BT * 60
	}


	///Total Belt Length for Round Pans
	///
	/// :returns: in
	private func CTBL() -> Double {
		return self.CVEL()
	}


	/// Number of Straight Across Pans
	///
	/// :returns: integer
	private func NSAP() -> Double {

		return BW / PD
	}


	/// Number of Rows of Sixty Degree Pans Across BW
	///
	/// :returns: integer
	private func NSDP() -> Double {
		return (BW - PD) / (sin(60 * PI / 180) * PD) + 1
	}


	/// Number of Odd Rows of Sixty Degree Pans
	///
	/// :returns: integer
	private func NOSP() -> Double {
		return round(self.NSDP() / 2)
	}


	/// Number Of Even Rows of Sixty Degree Pans
	///
	/// :returns: double
	private func NESP() -> Double {
		return Double(Int(round((self.NSDP() - 1) / 2)))
	}


	/// 60 Degree Odd Row Capacity
	///
	/// :returns: pans/hr
	private func SORC() -> Double {
		return round(self.CTBL() / PD) * NOSP()
	}


	/// 60 Degree Even Row Capacity
	///
	/// :returns: pans/hr
	private func SERC() -> Double {
		return Double(Int(round((self.CTBL() - (PD / 2)) / PD))) * NESP() + NESP()
	}


	/// 3 Pans V Formation Angle
	///
	/// :returns: degrees
	private func VFA() -> Double {
		return asin((BW - PD) / (2 * PD)) * 180 / PI
	}


	/// 3 Pans V Formation Small Angle Offset
	///
	/// :returns: in
	private func VSAO() -> Double {
		return 2 * sqrt(pow(PD, 2) - pow((BW - PD) / 2, 2))
	}


	/// 3 Pans V Offset
	///
	/// :returns: in
	private func VOST() -> Double {
		if (self.VFA() > 60) {
			return PD
		} else {
			return self.VSAO()
		}
	}


	/// 3 Pans Outter Rows Offset Capacity
	///
	/// :returns: pans/hr
	private func VOOC() -> Double {
		return self.CTBL() / self.VOST() * 2
	}


	/// 3 Pans V Outter Rows Extra Belt Length
	///
	/// :returns: in
	private func VOEB() -> Double {
		let temp: Double = self.CTBL() - (self.VOOC() / 2)
		return temp * self.VOST()
	}


	/// 3 Pans V Outter Rows Capacity
	///
	/// :returns: pans/hr
	private func VORC() -> Double {
		if (self.VOEB() >= PD) {
			return self.VOOC() + 2
		} else {
			return self.VOOC()
		}
	}


	/// 3 Pans V Middle Pan Offset
	///
	/// :returns: in
	private func VMPO() -> Double {
		return (BW - PD) / (2 * tan(self.VFA() * PI / 180))
	}


	/// 3 Pans V Middle Pan Offset Capacity
	///
	/// :returns: pans/hr
	private func VMOC() -> Double {
		return (self.CTBL() - self.VMPO()) / self.VOST()
	}


	/// 3 Pans V Middle Row Extra Belt Length
	///
	/// :returns: in
	private func VMEB() -> Double {
		let x: Double = self.CTBL() - self.VMPO()
		let y: Double = self.VMOC() * self.VOST()
		return x - y
	}


	/// 3 Pans V Middle Row Capacity
	///
	/// :returns: pans/hr
	private func VMRC() -> Double {
		if (self.VMEB() >= PD / 2) {
			return self.VMOC() + 1
		} else {
			return self.VMOC()
		}
	}


	/// 2 Pans Zig-Zag Formation Angle
	///
	/// :returns: degrees
	private func ZFA() -> Double {
		return asin((BW - PD) / PD) * 180 / PI
	}


	/// 2 Pans Zig-Zag Small Angle Offset
	///
	/// :returns: in
	private func ZSAO() -> Double {
		return 2 * sqrt(pow(PD, 2) - pow(BW - PD, 2))
	}


	/// 2 Pans Zig-Zag Offset
	///
	/// :returns: in
	private func ZOST() -> Double {
		if (self.ZFA() >= 60) {
			return PD
		} else {
			return self.ZSAO()
		}
	}


	/// 2 Pans Zig-Zag First Row Offset Capacity
	///
	/// :returns: pans/hr
	private func ZFOC() -> Double {
		return self.CTBL() / self.ZOST()
	}


	/// 2 Pans Zig-Zag First Row Extra Belt Length
	///
	/// :returns: in
	private func ZFEB() -> Double {
		return self.CTBL() - (self.ZFOC() * self.ZOST())
	}


	/// 2 Pans Zig-Zag First Row Capacity
	///
	/// :returns: pans/hr
	private func ZFC() -> Double {
		if (self.ZFEB() >= PD / 2) {
			return self.ZFOC() + 1
		} else {
			return self.ZFOC()
		}
	}


	/// 2 Pans Zig-Zag Second Pan Offset
	///
	/// :returns: in
	private func ZSPO() -> Double {
		return (BW - PD) * tan((PI / 180) * (90 - self.ZFA()))
	}


	/// 2 Pans Zig-Zag Second Row Offset Capacity
	///
	/// :returns: pans/hr
	private func ZSOC() -> Double {
		return (self.CTBL() - self.ZSPO()) / self.ZOST()
	}


	/// 2 Pans Zig-Zag Second Row Extra Belt Length
	///
	/// :returns: in
	private func ZSEB() -> Double {
		let x: Double = self.CTBL() - self.ZSPO()
		let y: Double = self.ZSOC() * self.ZOST()
		return x - y
	}


	/// 2 Pans Zig-Zag Second Row Capacity
	///
	/// :returns: pans/hr
	private func ZSC() -> Double {
		if (self.ZSEB() >= PD / 2) {
			return self.ZSOC() + 1
		} else {
			return self.ZSOC()
		}
	}


	/// Sixty Degree Capacity
	///
	/// :returns: pans/hr
	private func SDC() -> Double {
		if (BW / PD < 1) {
			return 0.0
		} else {
			return self.SORC() + self.SERC()
		}
	}


	/// 3 Pans V Capacity
	///
	/// :returns: pans/hr
	private func VC() -> Double {
		if (BW / PD <= 2) {
			return 0
		} else {
			if (BW / PD >= 3) {
				return 0
			} else {
				return self.VORC() + self.VMRC()
			}
		}
	}


	/// 2 Pans Zig-Zag Capacity
	///
	/// :returns: pans/hr
	private func ZC() -> Double {
		if (BW / PD <= 1) {
			return 0
		} else {
			if (BW / PD >= 2) {
				return 0
			} else {
				return self.ZFC() + self.ZSC()
			}
		}
	}


	/// Impinger Round Sheet Capacity
	///
	/// :returns: pans/hr
	private func IRC() -> Double {
		let max1: Double = max(self.SDC(), self.VC())
		return max(max1, ZC())
	}


	/// Velocity for rectangular pans
	///
	/// :returns: in/hr
	private func RVEL() -> Double {
		return OC / BT * 60
	}


	/// Total Belt Length for rectangular pans
	///
	/// :returns: in
	private func RTBL() -> Double {
		return self.RVEL()
	}


	/// Number of Pans Straiht Across Length Orientation
	///
	/// :returns: integer
	private func NPLO() -> Double {
		return BW / PL
	}


	/// Number of Pans Straight Across Width Orientation
	///
	/// :returns: integer
	private func NPWO() -> Double {
		return BW / PW
	}


	/// Pan Length Capacity
	///
	/// :returns: pans/hr
	private func PLC() -> Double {
		if (BW / PW < 1) {
			return 0
		} else {
			return Double(Int(round(self.RTBL() / PL) * self.NPWO()))
		}
	}


	/// Pan Width Capacity
	///
	/// :returns: pans/hr
	private func PWC() -> Double {
		if (BW / PL < 1) {
			return 0
		} else {
			return Double(Int(round(self.RTBL() / PW) * self.NPLO()))
		}
	}


	/// Impinger Rectangular Sheet Capacity
	///
	/// :returns: pans/hr
	private func ISC() -> Double {
		return max(self.PLC(), self.PWC())
	}

}