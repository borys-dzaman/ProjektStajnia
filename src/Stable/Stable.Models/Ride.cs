using System;
using System.Collections.Generic;
using System.Text;

namespace Stable.Models
{
	public class Ride
	{
		public RideType Type { get; set; }
		public TimeSpan RideDuration { get; set; }
		public int GroupSize { get; set; }
		public int RideCost { get; set; }
		public int RideId { get; set; }
	}
}
