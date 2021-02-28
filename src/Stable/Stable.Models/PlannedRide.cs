using System;
using System.Collections.Generic;
using System.Text;

namespace Stable.Models
{
	public class PlannedRide
	{
		public PlannedRideStatus Status { get; set; }
		public int RiderId { get; set; }
		public int RideId { get; set; }
		public DateTime RideDate { get; set; }	
	}
}
