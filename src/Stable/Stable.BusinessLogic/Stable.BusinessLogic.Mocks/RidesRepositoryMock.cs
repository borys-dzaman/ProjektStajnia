using System;
using System.Collections.Generic;
using Stable.Models;
using Stable.BusinessLogic.Interfaces;
using System.Linq;

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
            Ride rideQuery;
            rideQuery = RidesList.Where(x => x.RideId == RideId).FirstOrDefault();
            return rideQuery;
        }

        public RidesRepositoryStatus Add(Ride ride)
        {
            try
            {
                if (!(RidesList.Exists(x => x.RideId == ride.RideId)))
                {
                    RidesList.Add(ride);
                    RidesRepositoryStatus status = new RidesRepositoryStatus { Success = true };
                    return status;
                }
                else
                {
                    RidesRepositoryStatus status = new RidesRepositoryStatus { Success = false, ErrorDescription = "Ride with the same Id already exists!" };
                    return status;
                }              
            }
            catch(Exception ex)
            {
                RidesRepositoryStatus status = new RidesRepositoryStatus { Success = false, ErrorDescription = $"Could not add ride! {ex.Message}"};
                return status;
            }
        }

        public RidesRepositoryStatus Remove(Ride ride)
        {
            try
            {
                if (RidesList.Exists(x => x.RideId == ride.RideId))
                {
                    RidesList.Remove(ride);
                    RidesRepositoryStatus status = new RidesRepositoryStatus { Success = true };
                    return status;
                }
                else
                {
                    RidesRepositoryStatus status = new RidesRepositoryStatus { Success = false, ErrorDescription = "Ride does not exist!" };
                    return status;
                }
            }
            catch (Exception ex)
            {
                RidesRepositoryStatus status = new RidesRepositoryStatus { Success = false, ErrorDescription = $"Could not remove ride! {ex.Message}" };
                return status;
            }
        }

        public RidesRepositoryStatus Update(Ride ride)
        {
            try
            {
                if (RidesList.Exists(x => x.RideId == ride.RideId))
                {
                    Ride rideToUpdate;
                    rideToUpdate = RidesList.Where(x => x.RideId == ride.RideId).FirstOrDefault();
                    rideToUpdate = ride;
                    RidesRepositoryStatus status = new RidesRepositoryStatus { Success = true };
                    return status;
                }
                else
                {
                    RidesRepositoryStatus status = new RidesRepositoryStatus { Success = false, ErrorDescription = "Ride does not exist!" };
                    return status;
                }
            }
            catch (Exception ex)
            {
                RidesRepositoryStatus status = new RidesRepositoryStatus { Success = false, ErrorDescription = $"Could not update ride! {ex.Message}" };
                return status;
            }
        }
    }
}
