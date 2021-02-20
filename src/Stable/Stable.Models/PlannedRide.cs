using System;
using System.Collections.Generic;
using System.Text;

namespace Stable.Models
{
	public class PlannedRide
	{
		PlannedRideStatus status;
		public int RiderId { get; set; }
		public int RideId { get; set; }
		public DateTime RideDate { get; set; }	
	}
}
