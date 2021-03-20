using System;
using System.Collections.Generic;
using Stable.Models;
using Stable.BusinessLogic.Interfaces;

namespace Stable.BusinessLogic.Mocks
{
    public class RidesRepositoryMock : IRidesRepository
    {
        List<Ride> RidesList = new List<Ride>
        {
            new Ride { Type = RideType.AreaRide, RideId = 1, GroupSize = 3, RideDuration = new TimeSpan(0, 30, 0), RideCost = 40 },
            new Ride { Type = RideType.ShowJumping, RideId = 2, GroupSize = 1, RideDuration = new TimeSpan(0, 45, 0), RideCost = 55 },
            new Ride { Type = RideType.AreaRide, RideId = 3, GroupSize = 5, RideDuration = new TimeSpan(1, 0, 0), RideCost = 60 },
            new Ride { Type = RideType.Dressage, RideId = 4, GroupSize = 3, RideDuration = new TimeSpan(0, 45, 0), RideCost = 80 },
            new Ride { Type = RideType.LongAreaRide, RideId = 5, GroupSize = 2, RideDuration = new TimeSpan(2, 0, 0), RideCost = 100 }
        };

        public Ride GetById(int RideId)
        {
            return RidesList.Find(ride => ride.RideId == RideId);
        }

        public RidesRepositoryStatus Add(Ride ride)
        {
            try
            {
                RidesList.Add(ride);
                RidesRepositoryStatus status = new RidesRepositoryStatus { Success = true };
                return status;
            }
            catch
            {
                RidesRepositoryStatus status = new RidesRepositoryStatus { Success = false, ErrorDescription = "Could not add ride" };
                return status;
            }
        }

        public RidesRepositoryStatus Remove(Ride ride)
        {
            try
            {
                RidesList.Remove(ride);
                RidesRepositoryStatus status = new RidesRepositoryStatus { Success = true };
                return status;
            }
            catch
            {
                RidesRepositoryStatus status = new RidesRepositoryStatus { Success = false, ErrorDescription = "Could not remove ride" };
                return status;
            }
        }

        public RidesRepositoryStatus Update(Ride ride)
        {
            try
            {
                /*
                 * 
                 * Update implementation
                 * 
                 */
                RidesRepositoryStatus status = new RidesRepositoryStatus { Success = true };
                return status;
            }
            catch
            {
                RidesRepositoryStatus status = new RidesRepositoryStatus { Success = false, ErrorDescription = "Could not update ride" };
                return status;
            }
        }
    }
}
