using System;
using System.Collections.Generic;
using System.Text;

namespace Stable.Models
{
	public class PlannedRides
	{
		public int RiderId { get; }
		public int RideId { get; }
		public DateTime RideDate { get; set; }
		public enum PlannedRideStatus
        {
			None,
			Planned,
			Completed,
			CancelRequested,
			Cancelled
        }		
	}
}
