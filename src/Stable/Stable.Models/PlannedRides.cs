using System;
using System.Collections.Generic;
using System.Text;

namespace Stable.Models
{
	public class PlannedRides
	{
		public int PlannedRiderId { get; set; }
		public int PlannedRideId { get; set; }
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
