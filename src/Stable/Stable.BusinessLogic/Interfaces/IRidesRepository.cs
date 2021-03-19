using Stable.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Stable.BusinessLogic.Interfaces
{
	public interface IRidesRepository
	{
		Ride GetById(int RideId);
		RidesRepositoryStatus Add(Ride ride);
		RidesRepositoryStatus Remove(Ride ride);
		RidesRepositoryStatus Update(Ride ride);
	}
}