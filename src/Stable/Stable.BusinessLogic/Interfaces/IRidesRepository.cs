using System;
using System.Collections.Generic;
using System.Text;

namespace Stable.Models
{
	public interface IRidesRepository
	{
		Ride GetById(int RideId);
		void Add(Ride ride);
		void Remove(Ride ride);
		void Update(Ride ride);
	}
}