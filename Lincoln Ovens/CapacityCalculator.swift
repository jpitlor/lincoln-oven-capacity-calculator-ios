//
//  CapacityCalculator.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 7/23/15.
//  Copyright (c) 2015 Manitowoc Foodservice. All rights reserved.
//

import Foundation

class CapacityCalculator {
	private let BW: Double

	private let OC: Double

	private let BT: Double

	private let PD: Double

	private let PW: Double

	private let PL: Double

	private let isRound: Bool

	init(beltWidth: Double, ovenCapacity: Double, bakeTime: Double,
		 panDiameter: Double) {
		self.BW = beltWidth
		self.OC = ovenCapacity
		self.BT = bakeTime
		self.PD = panDiameter
		self.isRound = true

		self.PL = 0
		self.PW = 0
	}

	init(beltWidth: Double, ovenCapacity: Double, bakeTime: Double, panWidth: Double,
		 panLength: Double) {
		self.BW = beltWidth
		self.OC = ovenCapacity
		self.BT = bakeTime
		self.PL = panLength
		self.PW = panWidth
		self.isRound = false

		self.PD = 0
	}

	public func calculateCapacity() -> Double {
		let result = isRound ? IRC() : ISC()

		return (Math.round(result * 10) / 10) as Double
	}

	private func ROUNDVEL() -> Double {
		return OC / BT * 60
	}

	private func ROUNDTBL() -> Double {
		return ROUNDVEL()
	}

	private func NSAP() -> Double {
		return ((BW / PD) as Int) as Double
	}

	private func NSDP() -> Double {
		return (((BW - PD) / (0.866 * PD) + 1) as Int) as Double
	}

	private func NOSP() -> Double {
		return (Math.round(NSDP() / 2) as Int) as Double
	}

	private func NESP() -> Double {
		return (Math.round((NSDP() - 1) / 2) as Int) as Double
	}

	private func SORC() -> Double {
		return ((Math.round(ROUNDTBL() / PD) as Int) as Double) * NOSP()
	}

	private func SERC() -> Double {
		return ((Math.round((ROUNDTBL() - (PD / 2)) / PD) as Int) as Double) * NESP() + NESP()
	}

	private func VFA() -> Double {
		return Math.asin((BW - PD) / (2 * PD)) * 180 / Math.PI
	}

	private func VSAO() -> Double {
		return 2 * Math.sqrt(Math.pow(PD, 2) - Math.pow((BW - PD) / 2, 2))
	}

	private func VOST() -> Double {
		return VFA() > 60 ? PD : VSAO()
	}

	private func VOOC() -> Double {
		return (((ROUNDTBL() / VOST()) as Int) as Double) * 2
	}

	private func VOEB() -> Double {
		return ROUNDTBL() - (VOOC() / 2) * VOST()
	}

	private func VORC() -> Double {
		return VOEB() >= PD ? VOOC() + 2 : VOOC()
	}

	private func VMPO() -> Double {
		return (BW - PD) / (2 * Math.tan(VFA() * Math.PI / 180))
	}

	private func VMOC() -> Double {
		return (((ROUNDTBL() - VMPO()) / VOST()) as Int) as Double
	}

	private func VMEB() -> Double {
		return (ROUNDTBL() - VMPO()) - (VMOC() * VOST())
	}

	private func VMRC() -> Double {
		return VMEB() >= PD / 2 ? VMOC() + 1 : VMOC()
	}

	private func ZFA() -> Double {
		return Math.asin((BW - PD) / PD) * 180 / Math.PI
	}

	private func ZSAO() -> Double {
		return 2 * Math.sqrt(Math.pow(PD, 2) - Math.pow(BW - PD, 2))
	}

	private func ZOST() -> Double {
		return ZFA() >= 60 ? PD : ZSAO()
	}

	private func ZFOC() -> Double {
		return ((ROUNDTBL() / ZOST()) as Int) as Double
	}

	private func ZFEB() -> Double {
		return ROUNDTBL() - (ZFOC() * ZOST())
	}

	private func ZFC() -> Double {
		return ZFEB() >= PD / 2 ? ZFOC() + 1 : ZFOC()
	}

	private func ZSPO() -> Double {
		return (BW - PD) * Math.tan((Math.PI / 180) * (90 - ZFA()))
	}

	private func ZSOC() -> Double {
		return (((ROUNDTBL() - ZSPO()) / ZOST()) as Int) as Double
	}

	private func ZSEB() -> Double {
		return (ROUNDTBL() - ZSPO()) - (ZSOC() * ZOST())
	}

	private func ZSC() -> Double {
		return ZSEB() >= PD / 2 ? ZSOC() + 1 : ZSOC()
	}

	private func SDC() -> Double {
		return BW / PD < 1 ? 0 : SORC() + SERC()
	}

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

	private func IRC() -> Double {
		let max1: Double = Math.max(SDC(), VC())
		return Math.max(max1, ZC())
	}

	private func RECVEL() -> Double {
		return OC / BT * 60
	}

	private func RECTBL() -> Double {
		return RECVEL()
	}

	private func NPLO() -> Double {
		return ((BW / PL) as Int) as Double
	}

	private func NPWO() -> Double {
		return ((BW / PW) as Int) as Double
	}

	private func PLC() -> Double {
		return BW / PW < 1 ? 0 : ((Math.round(RECTBL() / PL) * NPWO()) as Int) as Double
	}

	private func PWC() -> Double {
		return BW / PL < 1 ? 0 : ((Math.round(RECTBL() / PW) * NPLO()) as Int) as Double
	}

	private func ISC() -> Double {
		return Math.max(PLC(), PWC())
	}

}