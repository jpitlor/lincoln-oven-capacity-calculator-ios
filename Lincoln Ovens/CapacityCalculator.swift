/// Coded by Jordan Pitlor, 2015
/// Formulas by Rob Townsend, 2002 (Updated by Christina Glaser, 2008)
/// <p/>
/// Please note that the figures above are potential capacity only and individual results will vary.
/// Actual capacity will fluctuate due to differences in environment, the type of product, ingredients,
/// finger kit, type of oven and oven temperature.

class CapacityCalculator {

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
	init(beltWidth: Double, ovenCapacity: Double, bakeTime: Double,
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
	init(beltWidth: Double, ovenCapacity: Double, bakeTime, panWidth: Double, panLength: Double) {
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
		let result: Double = panIsRound ? IRC() : ISC()

		return Math.round(result * 10) as Double / 10
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
		return CVEL()
	}


	/// Number of Straight Across Pans
	///
	/// :returns: integer
	private func NSAP() -> Int {

		return (BW / PD) as Int
	}


	/// Number of Rows of Sixty Degree Pans Across BW
	///
	/// :returns: integer
	private func NSDP() -> Int {
		return ((BW - PD) / (Math.sin(60 * Math.PI / 180) * PD) + 1) as Int
	}


	/// Number of Odd Rows of Sixty Degree Pans
	///
	/// :returns: integer
	private func NOSP() -> Int {
		return Math.round(NSDP() / 2)
	}


	/// Number Of Even Rows of Sixty Degree Pans
	///
	/// :returns: double
	private func NESP() -> Double {
		return (Math.round((NSDP() - 1) / 2) as Int) as Double
	}


	/// 60 Degree Odd Row Capacity
	///
	/// :returns: pans/hr
	private func SORC() -> Double {
		return (Math.round(CTBL() / PD) as Int) as Double * NOSP()
	}


	/// 60 Degree Even Row Capacity
	///
	/// :returns: pans/hr
	private func SERC() -> Double {
		return (Math.round((CTBL() - (PD / 2)) / PD) as Int) as Double * NESP() + NESP()
	}


	/// 3 Pans V Formation Angle
	///
	/// :returns: degrees
	private func VFA() -> Double {
		return Math.asin((BW - PD) / (2 * PD)) * 180 / Math.PI
	}


	/// 3 Pans V Formation Small Angle Offset
	///
	/// :returns: in
	private func VSAO() -> Double {
		return 2 * Math.sqrt(Math.pow(PD, 2) - Math.pow((BW - PD) / 2, 2))
	}


	/// 3 Pans V Offset
	///
	/// :returns: in
	private func VOST() -> Double {
		return VFA() > 60 ? PD : VSAO()
	}


	/// 3 Pans Outter Rows Offset Capacity
	///
	/// :returns: pans/hr
	private func VOOC() -> Int {
		return (CTBL() / VOST()) as Int * 2
	}


	/// 3 Pans V Outter Rows Extra Belt Length
	///
	/// :returns: in
	private func VOEB() -> Double {
		return CTBL() - (VOOC() / 2) * VOST()
	}


	/// 3 Pans V Outter Rows Capacity
	///
	/// :returns: pans/hr
	private func VORC() -> Double {
		return VOEB() >= PD ? VOOC() + 2 : VOOC()
	}


	/// 3 Pans V Middle Pan Offset
	///
	/// :returns: in
	private func VMPO() -> Double {
		return (BW - PD) / (2 * Math.tan(VFA() * Math.PI / 180))
	}


	/// 3 Pans V Middle Pan Offset Capacity
	///
	/// :returns: pans/hr
	private func VMOC() -> Int {
		return ((CTBL() - VMPO()) / VOST()) as Int
	}


	/// 3 Pans V Middle Row Extra Belt Length
	///
	/// :returns: in
	private func VMEB() -> Double {
		return (CTBL() - VMPO()) - (VMOC() * VOST())
	}


	/// 3 Pans V Middle Row Capacity
	///
	/// :returns: pans/hr
	private func VMRC() -> Double {
		return VMEB() >= PD / 2 ? VMOC() + 1 : VMOC()
	}


	/// 2 Pans Zig-Zag Formation Angle
	///
	/// :returns: degrees
	private func
			FA() -> Double {
		return Math.asin((BW - PD) / PD) * 180 / Math.PI
	}


	/// 2 Pans Zig-Zag Small Angle Offset
	///
	/// :returns: in
	private func ZSAO() -> Double {
		return 2 * Math.sqrt(Math.pow(PD, 2) - Math.pow(BW - PD, 2))
	}


	/// 2 Pans Zig-Zag Offset
	///
	/// :returns: in
	private func ZOST() -> Double {
		return ZFA() >= 60 ? PD : ZSAO()
	}


	/// 2 Pans Zig-Zag First Row Offset Capacity
	///
	/// :returns: pans/hr
	private func ZFOC() -> Int {
		return (CTBL() / ZOST()) as Int
	}


	/// 2 Pans Zig-Zag First Row Extra Belt Length
	///
	/// :returns: in
	private func ZFEB() -> Double {
		return CTBL() - (ZFOC() * ZOST())
	}


	/// 2 Pans Zig-Zag First Row Capacity
	///
	/// :returns: pans/hr
	private func ZFC() -> Double {
		return ZFEB() >= PD / 2 ? ZFOC() + 1 : ZFOC()
	}


	/// 2 Pans Zig-Zag Second Pan Offset
	///
	/// :returns: in
	private func ZSPO() -> Double {
		return (BW - PD) * Math.tan((Math.PI / 180) * (90 - ZFA()))
	}


	/// 2 Pans Zig-Zag Second Row Offset Capacity
	///
	/// :returns: pans/hr
	private func SOC() -> Int {
		return ((CTBL() - ZSPO()) / ZOST()) as Int
	}


	/// 2 Pans Zig-Zag Second Row Extra Belt Length
	///
	/// :returns: in
	private func ZSEB() -> Double {
		return (CTBL() - ZSPO()) - (ZSOC() * ZOST())
	}


	/// 2 Pans Zig-Zag Second Row Capacity
	///
	/// :returns: pans/hr
	private func ZSC() -> Double {
		return ZSEB() >= PD / 2 ? ZSOC() + 1 : ZSOC()
	}


	/// Sixty Degree Capacity
	///
	/// :returns: pans/hr
	private func SDC() -> Double {
		return BW / PD < 1 ? 0 : SORC() + SERC()
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
				return VORC() + VMRC()
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
				return ZFC() + ZSC()
			}
		}
	}


	/// Impinger Round Sheet Capacity
	///
	/// :returns: pans/hr
	private func IRC() -> Double {
		let max1: Double = Math.max(SDC(), VC())
		return Math.max(max1, ZC())
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
		return RVEL()
	}


	/// Number of Pans Straiht Across Length Orientation
	///
	/// :returns: integer
	private func NPLO() -> Int {
		return (BW / PL) as Int
	}


	/// Number of Pans Straight Across Width Orientation
	///
	/// :returns: integer
	private func NPWO() -> Int {
		return (BW / PW) as Int
	}


	/// Pan Length Capacity
	///
	/// :returns: pans/hr
	private func PLC() -> Double {
		return BW / PW < 1 ? 0 : ((Math.round(RTBL() / PL) * NPWO()) as Int) as Double
	}


	/// Pan Width Capacity
	///
	/// :returns: pans/hr
	private func PWC() -> Double {
		return BW / PL < 1 ? 0 : ((Math.round(RTBL() / PW) * NPLO()) as Int) as Double
	}


	/// Impinger Rectangular Sheet Capacity
	///
	/// :returns: pans/hr
	private func ISC() -> Double {
		return Math.max(PLC(), PWC())
	}

}