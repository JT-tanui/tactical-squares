import { Link, useLocation } from "react-router-dom";
import { Target, BookOpen, Play, User } from "lucide-react";

const Navigation = () => {
  const location = useLocation();

  return (
    <>
      {/* Desktop Navigation - Vertical */}
      <nav className="hidden md:flex fixed left-0 top-0 h-full bg-chess-primary w-64 flex-col shadow-lg z-50">
        <div className="p-4">
          <Link to="/" className="flex items-center gap-2 mb-8">
            <Target className="w-8 h-8 text-chess-accent" />
            <span className="text-xl font-bold text-chess-light">Chess AI Coach</span>
          </Link>
          
          <div className="flex flex-col gap-2">
            <NavItem to="/" icon={<Target />} label="Home" active={location.pathname === "/"} />
            <NavItem to="/learn" icon={<BookOpen />} label="Learn" active={location.pathname === "/learn"} />
            <NavItem to="/practice" icon={<Target />} label="Practice" active={location.pathname === "/practice"} />
            <NavItem to="/play" icon={<Play />} label="Play" active={location.pathname === "/play"} />
            <NavItem to="/profile" icon={<User />} label="Profile" active={location.pathname === "/profile"} />
          </div>
        </div>
      </nav>

      {/* Mobile Navigation */}
      <nav className="md:hidden fixed bottom-0 left-0 w-full bg-chess-primary p-4 z-50">
        <div className="flex justify-around gap-4">
          <NavItem to="/" icon={<Target />} label="Home" active={location.pathname === "/"} />
          <NavItem to="/learn" icon={<BookOpen />} label="Learn" active={location.pathname === "/learn"} />
          <NavItem to="/practice" icon={<Target />} label="Practice" active={location.pathname === "/practice"} />
          <NavItem to="/play" icon={<Play />} label="Play" active={location.pathname === "/play"} />
          <NavItem to="/profile" icon={<User />} label="Profile" active={location.pathname === "/profile"} />
        </div>
      </nav>
    </>
  );
};

const NavItem = ({ to, icon, label, active }: { to: string; icon: React.ReactNode; label: string; active: boolean }) => (
  <Link
    to={to}
    className={`flex items-center gap-3 px-4 py-3 rounded-lg transition-colors duration-200 ${
      active
        ? "text-chess-accent bg-chess-dark/50"
        : "text-chess-light hover:text-chess-accent hover:bg-chess-dark/30"
    }`}
  >
    <span className="text-xl">{icon}</span>
    <span className="text-sm font-medium">{label}</span>
  </Link>
);

export default Navigation;