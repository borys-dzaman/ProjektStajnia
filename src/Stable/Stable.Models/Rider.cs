using System;
using System.Collections.Generic;
using System.Text;

namespace Stable.Models
{
    public class Rider
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        public int SubscriptionType { get; set; }
        public TimeSpan SubscriptionExpiration { get; set; }
        public DateTime SubscriptionBuyDate { get; set; }
        public int AccountBalance { get; set; }
        public string Phone { get; set; }
    }
}
